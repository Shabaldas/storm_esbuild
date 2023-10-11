FactoryBot.define do
  factory :manual_order do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { "+38097#{1_000_000 + Random.rand(10_000_000 - 1_000_000)}" }
    email { Faker::Internet.email }
    app_contact { ManualOrder.app_contacts.values.sample }
    status { ManualOrder.statuses.values.sample }
    workflow_status { ManualOrder.workflow_statuses.values.sample }
    price_for_modeling { rand(100..500).to_s }
    price_for_printing { rand(100..500).to_s }
    print_color { ManualOrder::PRINTING_COLORS.sample }
    prepaid_expense { rand(100..200).to_s }
    total_price { rand(500..1000).to_s }
    comment { Faker::Religion::Bible.quote }
    end_date { Time.current - Random.rand(1..6).month }
  end
end
