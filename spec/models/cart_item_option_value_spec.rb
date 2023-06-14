RSpec.describe CartItemOptionValue do
  describe 'associations' do
    it { is_expected.to belong_to(:product_option_value) }
  end

  describe '#total' do
    it 'returns the total price of the cart item' do
      cart_item = build_stubbed(:cart_item, quantity: 2, product: build_stubbed(:product, price: 10))

      expect(cart_item.total).to eq(20)
    end
  end
end
