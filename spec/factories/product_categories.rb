FactoryBot.define do
  factory :product_category do
    sequence(:name) { Faker::Company.name }
    sequence(:description) { Faker::Company.catch_phrase }
    ancestry { nil }

    trait :with_parent do
      parent { create(:product_category) }
    end

    trait :with_children do
      after(:create) do |category|
        create_list(:product_category, 3, parent: category)
      end
    end
  end
end
