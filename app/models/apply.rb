class Apply < ActiveRecord::Base

  strip_attributes

  validates_associated :applicable, :rental_offering

  belongs_to  :applicable, polymorphic: true
  belongs_to  :rental_offering, counter_cache: true
  has_one     :co_sign

  after_commit :build_pdf_and_send_via_email, on: :create, if: 'Rails.env.production?'
  after_create :send_email_to_landlord
  after_create :tenant_screening
private

  def self.agreement(apply_id, attachment_id)
    apply = Apply.find(apply_id)
    document = ::Attachment.find(attachment_id).attachment.url
    if document
      begin
        @rs_connection = RightSignature::Connection.new(:api_token => ENV['RSAPITOKEN'])
        recipients = [
                      {:name => apply.applicable.first_name, :email => apply.applicable.email, :role => 'signer'},
                       {'is_sender' => true, :role => 'cc'}
                     ]
        options={
          :tags => [{:tag => {:name => 'sent_from_api'}}, {:tag => {:name => 'user_id', :value => '12345'}}],
          :expires_in => '5 days',
          :action => "send",
          'callback_location' => "https://fonda.herokuapp.com/v2/applies/right_signature_callback",
          'use_text_tags' => false
        }
        require 'open-uri'
        raw_data = open(document).read
        filename = "agreement.pdf"
        response = @rs_connection.send_document_from_data(raw_data, filename,'Please sign the agreement', recipients, options)
        apply.update_attributes(custom_agreement: true, agreement_status: response["document"]["status"],agreement_guid: response["document"]["guid"])
        return true
      rescue RightSignature::ResponseError => error
        return error.detailed_message
      end
    end
  end

  def build_pdf_and_send_via_email

    scheme_and_domain = (Rails.env.production? ? 'https://api.rentalgeek.com' : 'http://localhost:3000')

    applicant       = self.applicant.decorate
    rental_offering = self.rental_offering.decorate
    rental_complex  = rental_offering.rental_complex.decorate
    property_manager= rental_complex.property_manager.decorate

    applicant.email         = 'mdmooring@rentalgeek.com'
    property_manager.email  = 'mdmooring@rentalgeek.com'

    recipient_property_manager = {
      name:   property_manager.name,
      email:  property_manager.email
    }

    recipient_applicant = {
      name:   applicant.full_name,
      email:  applicant.email
    }

    text = <<-TEXT.strip_heredoc
      Dear #{applicant.full_name} and #{property_manager.name},


      You're receiving this e-mail because #{applicant.first_name} expressed an interest in a rental unit managed by #{property_manager.name}. Attached, you'll find a PDF of the tenant application.

      We'll let you two take it from here. You may want to CC potential roommates, schedule a showing, or get further information from each other.

      Lastly, we've also CC'd our Customer Support staff, who are here to help! Just let them know what you need.


      Happy Home-hunting,
      Rental Geek Customer Support
    TEXT

    attachment_content_uri = (!Rails.env.test? ? URI.join(scheme_and_domain, "/applies/#{self.id}").to_s : 'https://www.google.com/')

    $mandrill.messages.send({
      from_name:  'Rental Geek',
      from_email: 'no-reply@mail.rentalgeek.com',
      to: [ {
          name:   'Rental Geek| Customer Support',
          email:  'gstalab@gmail.com'
        },
        recipient_applicant,
        recipient_property_manager
      ],
      subject:  "#{applicant.full_name} wants to apply for the #{rental_offering.bedroom_count_compact} at #{rental_complex.full_address}!",
      text:     text,
      attachments: [
        { name:     "Rental Geek Application Form - #{applicant.full_name} (#{self.created_at.to_date.to_formatted_s(:short).strip}).pdf",
          type:     'application/pdf',
          content:  Base64.encode64(PDFKit.new(attachment_content_uri).to_pdf)
        }
      ],
      auto_html:            false,
      preserve_recipients:  true,
      track_opens:          false,
      track_clicks:         false
    })
  end

  def send_email_to_landlord

    @property = self.rental_offering
    @email = self.rental_offering.property_manager.customer_contact_email_address
    unless self.applicable.class.name=="RoommateGroup"
      @user = self.applicable.decorate.full_name
    else
      @user = self.applicable.name
    end
    ApplicantMailer.delay.landlord_email(@email,@user, @property)
  end

  def tenant_screening
    profile = Profile.find_by_applicant_id(self.applicable_id)
    if profile.victig_url.blank?
      begin
        tenant_info = XmlFu.xml(:BackgroundCheck => {"@userId" => ENV['VICTIG_USERNAME'],"@password" => ENV['VICTIG_PASSWORD'],
                                :BackgroundSearchPackage => {"@action" => "submit","@type" => "RentalGeek pacakge",
                                :PersonalData => {:PersonName => {:GivenName => profile.applicant.first_name, :FamilyName => profile.applicant.last_name},
                                :DemographicDetail => {:GovernmentId => {"@countryCode" => "US", "@issuingAuthority" => "SSN","=" => profile.ssn},
                                :DateOfBirth => profile.born_on.strftime("%Y-%m-%d")},
                                # :PostalAddress => {:CountryCode => "US", :PostalCode => "87111", :Region => "NM",
                                # :Municipality => "ALBUQUERQUE", :DeliveryAddress => {:AddressLine => "123", :StreetName => "Main"}}
                                },
                                :Screenings => {"Screening*" => [{"@type" => "credit"},
                                  {"@type" => "Criminal", "@qualifier" => 'multistate'},
                                  {"@type" => "eviction", "@qualifier" => 'singlestate'}],
                                "AdditionalItems*" => [{ "@type" => 'x:embed_credentials', :Text => "TRUE"},
                                  {"@type" => 'x:postback_url', :Text => "http://0.0.0.0:8080/v2/profiles/victig_callback"}]}}})

        xml_response = HTTParty.post("https://victig.instascreen.net/send/interchange", :body => tenant_info, :headers => { 'Content-Type' => 'application/xml' })
        response = Crack::XML.parse(xml_response)
        puts "************************"
        puts response

        order_id = response["BackgroundReports"]["BackgroundReportPackage"]["OrderId"]
        order_info = XmlFu.xml(:BackgroundCheck => {"@userId" => ENV['VICTIG_USERNAME'],"@password" =>ENV['VICTIG_PASSWORD'],
                                :BackgroundSearchPackage => {"@action" => "status", :OrderId => order_id}
                     })
        status_xml_response = HTTParty.post("https://victig.instascreen.net/send/interchange", :body => order_info, :headers => { 'Content-Type' => 'application/xml' })

        status_response = Crack::XML.parse(status_xml_response)
        puts "************************"
        puts response
        report_status = status_response["BackgroundReports"]["BackgroundReportPackage"]["ScreeningStatus"]["OrderStatus"]
        report_url = status_response["BackgroundReports"]["BackgroundReportPackage"]["ReportURL"]

        puts report_status
        puts report_url
        profile.victig_order_id = order_id
        profile.victig_url = report_url
        profile.save
      rescue
        puts "something went wrong in tenant background screening"
      end
    end
  end
end
