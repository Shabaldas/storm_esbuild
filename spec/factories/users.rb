FactoryBot.define do
  factory :user do
    sequence(:email) { |n| n.to_s + Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'greatSecurePasswordWith132456879and!@#%' }
    password_confirmation { 'greatSecurePasswordWith132456879and!@#%' }
    phone { Faker::PhoneNumber.phone_number }

    trait :admin do
      role { :admin }
    end

    trait :manager do
      role { :manager }
    end
  end
end
