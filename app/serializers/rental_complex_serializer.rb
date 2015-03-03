class RentalComplexSerializer < ActiveModel::Serializer

  attribute   :id
  attributes  :latitude,
              :longitude,
              :name,
              :full_address,
              :customer_contact_email_address,
              :customer_contact_phone_number,
              :salesy_description,
              :url
end

