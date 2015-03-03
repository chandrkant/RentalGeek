class ApplicantMailer < ActionMailer::Base
  default from: "\"RentalGeek\" <admin@rentalGeek.com>"

  def invitee_email(roommate_email,roommate_message, owner, group)
   	@emails = roommate_email
    @message = roommate_message
  	@group = group
    @properties = RentalOffering.find(group.applies.map(&:rental_offering_id))
  	@group_owner = owner
    mail(to: @emails, subject: owner + ' invited you to join a RentalGeek Roommate Group.')
  end

  def approve_applies(email,property_manager)
    @email=email
    @emails = property_manager.customer_contact_email_address
    @phone =  property_manager.customer_contact_phone_number
    mail(to: @email, subject: 'Your Application approved')
  end

  def soldout_email(property,email)
  	@email = email
  	@property_name = property
    mail(to: @email, subject: 'The RentalGeek property for which you applied has been sold, sorry. :( ')
  end

  def apply_email(roommate_email,owner,rental_offering)
    @emails = roommate_email
    @group_owner = owner
    @rental_offering = rental_offering
    mail(to: @emails, subject: 'You applied for a RentalGeek property!')
  end
  def cosigner_invite(roommate_email,current_user,property,apply_id,request)
    @emails = roommate_email
    @current_user = current_user
    @property = property
    @apply_id = apply_id
    @request = request
    mail(to: @emails, subject: current_user.email + ' invited to be their RentalGeek Co-Signer.')
  end
  def landlord_email(landlord_email,user,property)
    @email = landlord_email
    @user = user
    @property = property
    mail(to: @email, subject: 'Applied for your property')
  end
end
