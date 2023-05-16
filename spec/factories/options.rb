FactoryBot.define do
  factory :option do
    sequence(:title) { |n| "#{Faker::Commerce.color} #{n}" }
    measurement { :color }

    trait :with_option_values do
      transient do
        option_value_count { 3 }
      end

      after(:create) do |option, evaluator|
        create_list(:option_value, evaluator.option_value_count, option:)
      end
    end
  end
end
