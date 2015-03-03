# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :applicant do
    email                                     { Faker::Internet.free_email }
    password                                  { Faker::HipsterIpsum::characters(20) }
    password_confirmation                     { password }

    first_name                                { Faker::Name.first_name }
    last_name                                 { Faker::Name.last_name }
  end
end

