FactoryBot.define do
  factory :cost do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    amount { Faker::Number.decimal(l_digits: 2) }
    date { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    user
  end
end
