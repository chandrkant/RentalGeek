# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rental_offering do

    rental_complex
    
    monthly_rent_floor    { (300..1100).to_a.sample }
    monthly_rent_ceiling  { monthly_rent_floor }
    
    bedroom_count         2
    full_bathroom_count   1
    
    headline      { Faker::Product::product }
  end
end
