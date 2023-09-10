FactoryBot.define do
  factory :manual_order do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    phone_number { '+380976404050' }
    email { Faker::Internet.email }
    app_contact { ManualOrder.app_contacts.values.sample }
    status { ManualOrder.statuses.values.sample }
    price_for_modeling { rand(100..500).to_s }
    price_for_printing { rand(100..500).to_s }
    print_color { ManualOrder::PRINTING_COLORS.sample }
    total_price { rand(500..1000).to_s }
  end
end
