RSpec.describe CartItem do
  describe 'associations' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:cartable) }
    it { is_expected.to have_many(:cart_item_option_values).dependent(:destroy) }
  end

  describe '#total' do
    let(:product_category) { create(:product_category, :with_parent) }
    let(:product) { create(:product, product_category:, price: 10) }
    let(:cart_item) { create(:cart_item, quantity: 2, cartable_id: product.id, cartable_type: product.class.name) }
    let(:product_option) { create(:product_option, product:, primary: true) }
    let(:product_option_value) { create(:product_option_value, product_option:) }
    let(:cart_item_option_value) { create(:cart_item_option_value, cart_item_id: cart_item.id, product_option_value:) }

    it 'returns the total price of the cart item' do
      expect(cart_item.total).to eq(20)
    end
  end
end
