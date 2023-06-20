describe Carts::RemovesController do
  describe 'DELETE /destroy' do
    let(:cart) { create(:cart) }

    before do
      allow(controller).to receive(:current_cart).and_return(cart)
    end

    context 'when product exists' do
      let(:product_first) { create(:product) }
      let(:product_second) { create(:product) }
      let(:cart_item_first) { create(:cart_item, cart:, cartable_id: product_first.id, cartable_type: product_first.class.name, quantity: 2) }
      let(:cart_item_second) { create(:cart_item, cart:, cartable_id: product_second.id, cartable_type: product_second.class.name, quantity: 4) }

      before do
        cart_item_first
        cart_item_second
      end

      it 'creates a new cart_item' do
        post :destroy, params: { product_id: product_first.id }
        cart.reload

        expect(cart.cart_items.last.quantity).to eq(4)
        expect(cart.cart_items.last.cartable).to eq(product_second)
        expect(cart.cart_items).not_to include(product_first)
      end
    end

    context 'when product does not exist' do
      it 'does not create a new cart_item' do
        post :destroy, params: { product_id: 0 }

        expect(cart.cart_items.count).to eq(0)
      end
    end
  end
end
