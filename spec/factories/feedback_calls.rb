FactoryBot.define do
  factory :feedback_call do
    phone_number { Faker::PhoneNumber.cell_phone }
    processed { false }
  end
end
