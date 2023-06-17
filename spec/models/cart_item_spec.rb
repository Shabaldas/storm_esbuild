RSpec.describe CartItem do
  describe 'associations' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:cartable) }
    it { is_expected.to have_many(:cart_item_option_values).dependent(:destroy) }
  end

  describe "#total" do
    let!(:product) { create(:product, price: 10) }
    let(:cart_item) { create(:cart_item, quantity: 2, cartable_id: product.id, cartable_type: product.class.name) }
    
    it "returns the total price of the cart item" do
      expect(cart_item.total).to eq(20)
    end
  end
end
