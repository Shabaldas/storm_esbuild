FactoryBot.define do
  factory :order do
    cart
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
  end
end
