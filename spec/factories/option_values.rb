FactoryBot.define do
  factory :option_value do
    option
    value { Faker::Commerce.unique.material }
  end
end
