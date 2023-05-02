FactoryBot.define do
  factory :product_option do
    product
    option
    primary { false }
  end
end
