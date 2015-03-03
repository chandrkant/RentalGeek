class RentalOfferingSerializer < ActiveModel::Serializer

  attribute   :id
  attributes  :bedroom_count,
              :applies_count,
              # :rentalgeek_applies,
              :full_bathroom_count,
              :half_bathroom_count,
              :monthly_rent_floor,
              :monthly_rent_ceiling,
              :square_footage_floor,
              :square_footage_ceiling,
              :url,
              :headline,
              :earliest_available_on,
              :rental_offering_type,
              :customer_contact_email_address,
              :customer_contact_phone_number,
              :earliest_available_on,
              :salesy_description,
              :earliest_available_on,
              :buzzer_intercom,
              :central_air,
              :deck_patio,
              :dishwater,
              :doorman,
              :elevator,
              :fireplace,
              :gym,
              :hardwood_floor,
              :new_appliances,
              :parking_garage,
              :parking_outdoor,
              :pool,
              :storage_space,
              :vaulted_ceiling,
              :walkin_closet,
              :washer_dryer,
              :yard_private,
              :yard_shared,
              :scrape_amenities,
              :starred,
              :rental_complex_latitude,
              :rental_complex_longitude,
              :rental_complex_name,
              :rental_complex_full_address,
              :rental_complex_street_name,
              :rental_complex_cross_street_name,
              :rental_complex_walk_time,
              :rental_complex_nearby_places,

              :property_manager_accepts_cash,
              :property_manager_accepts_checks,
              :property_manager_accepts_credit_cards_offline,
              :property_manager_accepts_online_payments,
              :property_manager_accepts_money_orders

  delegate  :latitude,
            :longitude,
            :name,
            :full_address,
            :street_name,
            :cross_street_name,
            :walk_time,
            :nearby_places,
              to: :rental_complex,
              prefix: true

  delegate  :accepts_cash,
            :accepts_checks,
            :accepts_credit_cards_offline,
            :accepts_online_payments,
            :accepts_money_orders,
              to: :property_manager,
              prefix: true
  delegate :current_applicant, to: :scope

private

  def url
    return object.url                           unless object.url.blank?
    return rental_complex.url                   unless rental_complex.url.blank?
    return rental_complex.property_manager.url
  end

  def customer_contact_email_address
    return rental_complex.customer_contact_email_address  unless rental_complex.customer_contact_email_address.blank?
    return property_manager.customer_contact_email_address
  end

  def customer_contact_phone_number
    return rental_complex.customer_contact_phone_number   unless rental_complex.customer_contact_phone_number.blank?
    return property_manager.customer_contact_phone_number
  end

  def rental_complex
     object.rental_complex
  end
  def property_manager
    rental_complex.property_manager
  end

  def salesy_description
    return object.salesy_description            unless object.salesy_description.blank?
    return rental_complex.salesy_description
  end

  def buzzer_intercom
    object.buzzer_intercom
  end

  def central_air
    object.central_air
  end

  def deck_patio
    object.deck_patio
  end

  def dishwater
    object.dishwater
  end

  def doorman
    object.doorman
  end

  def elevator
    object.elevator
  end

  def fireplace
    object.fireplace
  end

  def gym
    object.gym
  end

  def hardwood_floor
    object.hardwood_floor
  end

  def new_appliances
    object.new_appliances
  end

  def parking_garage
    object.parking_garage
  end

  def parking_outdoor
    object.parking_outdoor
  end

  def storage_space
    object.storage_space
  end

  def vaulted_ceiling
    object.vaulted_ceiling
  end

  def walkin_closet
    object.walkin_closet
  end

  def washer_dryer
    object.washer_dryer
  end

  def yard_private
    object.yard_private
  end

  def yard_shared
    object.yard_shared
  end

  def rentalgeek_applies
    if !object.applies.blank?
      object.applies.each do |ob|
         ob.id
       end

    end
  end

  def starred
    if current_applicant
     object.starred_properties.map(&:applicant_id).include?(current_applicant.id) ? true : false
   else
    false
   end
  end

end

