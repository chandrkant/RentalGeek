class ApplySerializer < ActiveModel::Serializer
  attribute   :id
  attributes  :property_address,:property_rentalgeek_id, :custom_agreement, :agreement_status,
              :bedroom_count,:full_bathroom_count,:square_footage_floor,:square_footage_floor,
              :monthly_rent_floor,:salesy_description,:image,:accepted,:agreement_guid,
              :agreement_url, :sold_out, :email,:full_name,:profile_id,:victig_url,:applicable

  private

  def email
    unless object.applicable.class.name=="RoommateGroup"
     return object.applicable.email
    else
     return object.applicable.owner.email
    end
  end

  def full_name
     unless object.applicable.class.name=="RoommateGroup"
     return object.applicable.decorate.full_name
    else
     return object.applicable.name
    end

  end

  def applicable
    if object.applicable_type=='Applicant'
      return true
    else
      return false
    end
  end

  def profile_id
    unless object.applicable.class.name=="RoommateGroup"
      return object.applicable.profile.id if object.applicable.profile
    else
      return object.applicable.owner.profile.id if object.applicable.owner.profile
    end
  end

  def victig_url
    return object.applicable.profile.victig_url if object.applicable_type == "Applicant" && object.applicable.profile
  end

  def property_address
    return object.rental_offering.headline
  end

  def property_rentalgeek_id
    return object.rental_offering.id
  end

  def bedroom_count
    return object.rental_offering.bedroom_count
  end

  def full_bathroom_count
    return object.rental_offering.full_bathroom_count
  end

  def square_footage_floor
    return object.rental_offering.square_footage_floor
  end

  def monthly_rent_floor
    return object.rental_offering.monthly_rent_floor
  end

  def salesy_description
    return object.rental_offering.salesy_description
  end

  def image
    object.rental_offering.property_photos.first.photo.url(:full) if object.rental_offering.property_photos.first
  end
  def sold_out
    return object.rental_offering.sold_out
  end
end







