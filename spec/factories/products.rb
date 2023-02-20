FactoryBot.define do
  factory :product do
    sequence(:name) { Faker::Commerce.product_name }
    sequence(:description) { Faker::Company.catch_phrase }
    association :product_category
    sequence(:price) { Faker::Commerce.price(range: 0..100.0) }
    sequence(:status) { 1 }
  end
end
