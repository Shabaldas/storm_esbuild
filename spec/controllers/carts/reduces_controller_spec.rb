describe Carts::ReducesController do
  describe 'POST /carts/reduces' do
    let(:cart) { create(:cart) }

    before do
      allow(controller).to receive(:current_cart).and_return(cart)
    end

    context 'when product exists' do
      let(:product_first) { create(:product) }
      let(:product_second) { create(:product) }
      let(:cart_item_first) { create(:cart_item, cart:, product: product_first, quantity: 4) }
      let(:cart_item_second) { create(:cart_item, cart:, product: product_second, quantity: 2) }

      before do
        cart_item_first
        cart_item_second
      end

      it 'creates a new cart_item' do
        post :create, params: { product_id: product_first.id }

        expect(cart.cart_items.count).to eq(2)
        expect(cart.cart_items.first.quantity).to eq(3)
        expect(cart.cart_items.second.quantity).to eq(2)
        expect(cart.cart_items.first.product).to eq(product_first)
        expect(cart.cart_items.second.product).to eq(product_second)
      end
    end

    context 'when product does not exist' do
      it 'does not create a new cart_item' do
        post :create, params: { product_id: 0 }

        expect(cart.cart_items.count).to eq(0)
      end
    end
  end
end