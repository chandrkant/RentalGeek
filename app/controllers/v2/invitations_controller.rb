class V2::InvitationsController < V2::BaseEntityController

	def index
		email = current_applicant.email
		@invitations = Invitation.where(:email => email, :status => false)
		render json: @invitations, root: "invitations"
	end

	def accept
		@invitation = Invitation.find(params[:invitation_id])
		@roommate_group = @invitation.roommate_group
		@roommate_group.applicants << Applicant.find_by_email(@invitation.email)
		@invitation.update_attribute('status', true)
		email = current_applicant.email
		@invitations = Invitation.where(:email => email, :status => false)
		render json: @invitations, root: "invitations"
	end

	def deny
		@invitation = Invitation.find(params[:invitation_id])
		@invitation.destroy
		email = current_applicant.email
		@invitations = Invitation.where(:email => email, :status => false)
		render json: @invitations, root: "invitations"
	end

  private
  def _entity_params
    params.require(:invitation).permit()
  end

  def _get_class
    Invitation
  end

end
