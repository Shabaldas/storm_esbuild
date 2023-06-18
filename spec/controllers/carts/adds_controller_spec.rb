describe Carts::AddsController do
  describe 'POST /carts/adds' do
    let(:product) { create(:product) }
    let(:cart) { create(:cart) }

    before do
      allow(controller).to receive(:current_cart).and_return(cart)
    end

    # TODO: Fix this test
    context 'when product exists' do
      xit 'creates a new cart_item' do
        post :create, params: { product_id: product.id }

        expect(cart.cart_items.count).to eq(1)
        expect(cart.cart_items.first.quantity).to eq(1)
        expect(cart.cart_items.first.product).to eq(product)
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
