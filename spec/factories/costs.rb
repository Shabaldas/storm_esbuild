FactoryBot.define do
  factory :cost do
    association :user
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    amount { Faker::Number.decimal(l_digits: 2) }
    date { Faker::Date.between(from: 2.days.ago, to: Time.zone.today) }
  end
end
