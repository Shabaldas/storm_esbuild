FactoryBot.define do
  factory :cart_item do
    association :cart
    association :cartable, factory: :product
    quantity { 1 }
  end
end
