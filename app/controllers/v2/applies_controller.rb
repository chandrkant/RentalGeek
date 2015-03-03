require 'crack/xml'
require 'socket'

class V2::AppliesController < V2::BaseEntityController
  skip_before_filter :authenticate_applicant_from_token!, :only => [:right_signature_callback, :local_ip, :ip]
  skip_before_filter :authenticate_applicant!, :only => [:right_signature_callback, :local_ip, :ip]

  def index
    @apply = current_applicant.applies.includes(:rental_offering, :applicable)
    render json: @apply
  end

  def approve
    @apply = Apply.find(params[:apply_id])
    @apply.update_attribute('accepted', true)
    unless @apply.applicable.class.name=="RoommateGroup"
     ApplicantMailer.delay.approve_applies(@apply.applicable.email ,@apply.rental_offering.property_manager)
    else
      ApplicantMailer.delay.approve_applies(@apply.applicable.owner.email ,@apply.rental_offering.property_manager)
    end
    render nothing: true
  end

  def dis_approve
    @apply = Apply.find(params[:apply_id])
    @apply.update_attribute('accepted', nil)
    render nothing: true
  end

  def deny
    @apply = Apply.find(params[:apply_id])
    @apply.update_attribute('accepted', false)
    RentalOffering.decrement_counter(:applies_count, @apply.rental_offering.id)
    render nothing: true
  end

  def send_agreement
    @agreement = Apply.agreement(params[:apply_id], params[:attachment_id])
    if @agreement == true
      render json: {:success=>true}
    else
      render json: @agreement, status: :unprocessable_entity
    end
  end

  def right_signature_callback
    begin
      response = Crack::XML.parse(request.body.read)
      @apply = Apply.find_by_agreement_guid(response["callback"]["guid"])
      @apply.update_attributes(:agreement_status => response["callback"]["status"])
      if response["callback"]["status"] == "recipient_signed"
        @rs_connection = RightSignature::Connection.new(:api_token => ENV['RSAPITOKEN'])
        details = @rs_connection.document_details(response["callback"]["guid"])
        @apply.update_attributes(:agreement_url =>  CGI::unescape(details["document"]["signed_pdf_url"]))
      end
      render nothing: true
    rescue
      render nothing: true
    end
  end

  def home

  end

  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end

  def ip
    puts "Ip address*****************************"
    puts local_ip
    puts "******************************"
    render nothing: true
  end

  private

  def _entity_params
    params.require(:apply).permit(:applicable_id, :applicable_type, :rental_offering_id)
  end

  def _get_class
    Apply
  end
end

