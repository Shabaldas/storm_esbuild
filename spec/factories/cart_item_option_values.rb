FactoryBot.define do
  factory :cart_item_option_value do
    association :cart_item
    association :product_option_value
  end
end
