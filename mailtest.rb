apply_id = 1411296

scheme_and_domain = (Rails.env.production? ? 'https://api.rentalgeek.com' : 'http://localhost:3000')

apply = Apply
  .where(rentalgeek_id: apply_id)
  .includes(:applicant)
  .includes(:rental_offering => {:rental_complex => :property_manager})
  .first!

applicant       = apply.applicant.decorate
rental_offering = apply.rental_offering.decorate
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

$mandrill.messages.send({
  from_name:  'Rental Geek',
  from_email: 'no-reply@mail.rentalgeek.com',
  to: [ {
      name:   'Rental Geek| Customer Support',
      email:  'mdmooring@rentalgeek.com'
    },
    recipient_applicant,
    recipient_property_manager
  ],
  subject:  "#{applicant.full_name} wants to apply for the #{rental_offering.bedroom_count_compact} at #{rental_complex.full_address}!",
  text:     text, 
  attachments: [
    { name:     "Rental Geek Application Form - #{applicant.full_name} (#{apply.created_at.to_date.to_formatted_s(:short).strip}).pdf",
      type:     'application/pdf',
      content:  Base64.encode64(PDFKit.new(URI.join(scheme_and_domain, "/applies/#{apply.rentalgeek_id}").to_s).to_pdf)
    }
  ],
  auto_html:            false,
  preserve_recipients:  true,
  track_opens:          false,
  track_clicks:         false
})

