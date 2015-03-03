class StarredPropertySerializer < ActiveModel::Serializer

  attributes  :id, :applicant_id,:rental_offering_id,
              :property_address,
              :bedroom_count,:full_bathroom_count,:square_footage_floor,
              :monthly_rent_floor,:salesy_description,:image,
              :sold_out

 private




  def property_address

    return object.rental_offering.headline
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







