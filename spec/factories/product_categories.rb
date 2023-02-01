FactoryBot.define do
  factory :product_category do
    sequence(:name) { Faker::Company.name }
    sequence(:description) { Faker::Company.catch_phrase }

    trait :with_parent do
      after(:build) do |category|
        category.parent = FactoryBot.create(:product_category)
      end
    end
  end
end
