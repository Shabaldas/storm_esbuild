FactoryBot.define do
  factory :manual_order do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
  end
end
