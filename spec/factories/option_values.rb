FactoryBot.define do
  factory :option_value do
    option
    sequence(:value) { |n| "#{Faker::Commerce.color} #{n}" }
  end
end
