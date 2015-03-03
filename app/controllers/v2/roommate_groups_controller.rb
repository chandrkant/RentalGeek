class V2::RoommateGroupsController < V2::BaseEntityController

  def index
    sql = "applicant_id = #{current_applicant.id.to_i}"
  	@roommate_groups = RoommateGroup.includes(:applicants).where(sql)
  	render json: @roommate_groups
  end

  def member_groups
    @applicant = current_applicant
    @member_groups = @applicant.roommate_groups
    render json: {:member_groups => @member_groups}
  end

  def left_group
    @roommate_group = RoommateGroup.find(params[:roommate_group_id])
    @member = current_applicant
    @roommate_group.applicants.delete(@member)
    @member_groups = @member.roommate_groups
    render json: {:member_groups => @member_groups}

  end

  def update
     @roommate_group = RoommateGroup.find(params[:id])
     if @roommate_group.update_attributes(:name => params[:value])
      respond_with @roommate_group, entity: _get_class
     else
      respond_with(@roommate_group, status: :unprocessable_entity, json: @roommate_group.errors, entity: _get_class)
     end
  end

  def invite_roommates
    @roommate_group = RoommateGroup.find(params[:roommate_group_id])
    invitee = params[:roommate_group][:invitee].split(",")
    invitee.each do |invite|
      if @roommate_group.applicants.where(:email => invite).blank?
        @invitation = @roommate_group.invitations.new(:email => invite)
        @invitation.save
      end
    end
    ApplicantMailer.delay.invitee_email(params[:roommate_group][:invitee], params[:roommate_group][:message], @roommate_group.owner.email, @roommate_group)
    render json: {:success=>true}
  end

  def remove_member
    @roommate_group = RoommateGroup.find(params[:roommate_group_id])
    @member = Applicant.find(params[:roommate_group][:member])
    @roommate_group.applicants.delete(@member)
    render json: @roommate_group, root: "roommate_group"
  end

  def apply_roommates
    applies = params[:apply][:roommate_groups]
    applies.each do |key,apply|
      @email = RoommateGroup.find(apply[:id]).applicants.map(&:email).join(',')
      @apply = Apply.create!(applicable_id: apply[:id], applicable_type: "RoommateGroup", rental_offering_id: params[:apply][:rental_offering_id])
      @rental_offering = RentalOffering.find(params[:apply][:rental_offering_id])
      ApplicantMailer.delay.apply_email(@email, current_applicant.email, @rental_offering) unless @email.blank?
    end
    render json: {:success=>true}
  end

  private

  def _entity_params
    params.require(:roommate_group).permit!
  end

  def _get_class
    RoommateGroup
  end
end
