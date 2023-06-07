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

    trait :color_measurement do
      title { 'Color' }
      measurement { 'color' }
      after(:create) do |option|
        ['White', 'Black', 'Green', 'Red', 'Blue', 'Yellow', 'Gray'].each do |color|
          option.option_values.create(value: color) unless option.option_values.exists?(value: color)
        end
      end
    end

    trait :size_measurement do
      tutorial { 'Size' }
      measurement { 'mm' }
      after(:create) do |option|
        ['S', 'L', 'M', 'XS', 'XL'].each do |size|
          option.option_values.create(value: size) unless option.option_values.exists?(value: size)
        end
      end
    end
  end
end
