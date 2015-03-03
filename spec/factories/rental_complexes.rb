# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rental_complex do
  
    property_manager

    full_address  "24 Maujer St, Brooklyn, 11206 " # { Faker::AddressUS::street_address  }

#    ignore          { coordinates { Faker::Geolocation::LATLNG.rand } }
#    latitude        { coordinates[0] }
#    longitude       { coordinates[1] }
    
    name            { Faker::Product::product }
  end
end
