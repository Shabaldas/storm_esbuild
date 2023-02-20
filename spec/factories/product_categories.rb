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

    trait :with_products do
      transient do
        product_count { 3 } # number of products to create for this category
      end

      after(:create) do |category, evaluator|
        create_list(:product, evaluator.product_count, product_category: category)
      end
    end
  end
end
