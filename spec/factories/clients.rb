FactoryBot.define do
  factory :client do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { "+38097#{1_000_000 + Random.rand(10_000_000 - 1_000_000)}" }
    email { Faker::Internet.email }
  end
end
