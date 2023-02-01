FactoryBot.define do
  factory :user do
    sequence(:email) { |n| n.to_s + Faker::Internet.email }
    password { 'greatSecurePasswordWith132456879and!@#%' }
    password_confirmation { 'greatSecurePasswordWith132456879and!@#%' }

    trait :admin do
      role { :admin }
    end
  end
end
