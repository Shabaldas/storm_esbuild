FactoryBot.define do
  factory :modeling_order do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    phone_number { '+380976404050' }
    email { Faker::Internet.email }
    total_price { '500' }
  end
end
