class Ability
  include CanCan::Ability

  def initialize(applicant)
    # Define abilities for the passed in user here. For example:
    #
    applicant ||= Applicant.new # guest user (not logged in)
    alias_action :create, :read, :update, :destroy, :to => :crud
    # if applicant.admin?
    #   can :manage, :all
    if applicant.property_manager?
      can :manage, RentalComplex, :property_manager_id => applicant.property_manager.id
      can :manage, RentalOffering, :rental_complex_id => applicant.property_manager.rental_complex_ids
      can :manage, Attachment, :property_manager_id => applicant.property_manager.id

      can :manage, Applicant, :id => applicant.id
      can :manage, Apply, applicable_type: 'Applicant', applicable_id: applicant.id
      can :manage, Apply, applicable_type: 'RoommateGroup', applicable_id: applicant.roommate_group_ids
      can :manage, Apply, :rental_offering_id => applicant.property_manager.rental_offering_ids
      can :manage, CoSign, :co_signer_id => applicant.co_signer.id if applicant.co_signer
      can :read, CoSign
      can :manage, CoSigner, :applicant_id => applicant.id
      can :read, CoSigner
      can :manage, Invitation, :email => applicant.email
      can :manage, Profile, :applicant_id => applicant.id
      can :read, Profile
      can :manage, PropertyPhoto, :rental_offering_id => applicant.property_manager.rental_offering_ids
      can :read, PropertyPhoto
      can :manage, Provider, :applicant_id => applicant.id
      can :manage, RoommateGroup, :applicant_id => applicant.id
      can :manage, StarredProperty, :applicant_id => applicant.id
      can :manage, Transaction, :applicant_id => applicant.id
      can :manage, PropertyManager, :applicant_id => applicant.id
    else
      can :manage, Applicant, :id => applicant.id
      can :manage, Apply, applicable_type: 'Applicant', applicable_id: applicant.id
      can :manage, Apply, applicable_type: 'RoommateGroup', applicable_id: applicant.roommate_group_ids
      #can :crud, Attachment
      can :manage, CoSign, :co_signer_id => applicant.co_signer.id if applicant.co_signer
      can :manage, CoSigner, :applicant_id => applicant.id
      can :manage, Invitation, :email => applicant.email
      can :manage, Profile, :applicant_id => applicant.id
      can :read, PropertyPhoto
      can :manage, Provider, :applicant_id => applicant.id
      can :read, RentalComplex
      can :read, RentalOffering
      can :manage, RoommateGroup, :applicant_id => applicant.id
      can :manage, StarredProperty, :applicant_id => applicant.id
      can :manage, Transaction, :applicant_id => applicant.id
    end
  end
end
