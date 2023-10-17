FactoryBot.define do
  factory :worker do
    user
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    nickname { Faker::Name.name }
  end
end
