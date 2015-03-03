class InvitationSerializer < ActiveModel::Serializer
	attributes  :id, :roommate_group_id, :groupname, :inviter

  private

  def groupname
    object.roommate_group.name
  end

  def inviter
  	object.roommate_group.owner.email
  end
end