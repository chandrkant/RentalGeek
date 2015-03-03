# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property_manager do

    name                                      { Faker::Company.name }
    customer_contact_email_address            { Faker::Internet.free_email }

    url                                       { Faker::Internet.http_url }

    sequence(:customer_contact_phone_number,500_0000) { |local_portion| "785#{local_portion}" }
  end
end

