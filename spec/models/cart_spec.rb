RSpec.describe Cart do
  describe 'associations' do
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
  end

  describe '#total_price' do
    let(:product_category) { create(:product_category, :with_parent) }
    let(:cart) { create(:cart) }
    let!(:product) { create(:product, product_category:) }
    let!(:cart_item) { create(:cart_item, cart:, quantity: 2, cartable_id: product.id, cartable_type: product.class.name) }
    let(:product_option) { create(:product_option, product:, primary: false) }
    let(:product_option_value) { create(:product_option_value, product_option:, price: 10) }
    let(:cart_item_option_value) { create(:cart_item_option_value, cart_item_id: cart_item.id, product_option_value:) }

    before do
      cart_item_option_value
    end

    it 'returns total price' do
      expect(cart.reload.total_price).to eq(20)
    end
  end
end
