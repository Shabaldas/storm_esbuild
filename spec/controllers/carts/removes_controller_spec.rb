describe Carts::RemovesController do
  describe 'DELETE /destroy' do
    let(:cart) { create(:cart) }

    before do
      allow(controller).to receive(:current_cart).and_return(cart)
    end

    context 'when product exists' do
      let(:product_category) { create(:product_category, :with_parent) }
      let(:product_first) { create(:product, product_category:) }
      let(:product_second) { create(:product, product_category:) }
      let(:product_option_size) { create(:product_option, product: product_first, primary: false) }
      let!(:product_option_value_first) { create(:product_option_value, product_option: product_option_size, price: 10) }
      let!(:product_option_value_second) { create(:product_option_value, product_option: product_option_size, price: 20) }
      let!(:cart_item_first) { create(:cart_item, cart:, cartable_id: product_first.id, cartable_type: product_first.class.name, quantity: 3) }
      let!(:cart_item_second) { create(:cart_item, cart:, cartable_id: product_second.id, cartable_type: product_second.class.name, quantity: 4) }
      let(:cart_item_option_value_first) do
        create(:cart_item_option_value, cart_item_id: cart_item_first.id, product_option_value_id: product_option_value_first.id)
      end
      let(:cart_item_option_value_second) do
        create(:cart_item_option_value, cart_item_id: cart_item_second.id, product_option_value_id: product_option_value_second.id)
      end

      before do
        product_first
        product_second
        cart_item_option_value_first
        cart_item_option_value_second
      end

      it 'creates a new cart_item' do
        post :destroy, params: { cart_item: product_first.id }
        cart.reload

        cart_item = cart.cart_items.last

        expect(cart_item.quantity).to eq(4)
        expect(cart_item.cartable).to eq(product_second)
        expect(cart.cart_items).not_to include(product_first)
      end
    end
  end
end
