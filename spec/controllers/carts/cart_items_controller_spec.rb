describe Carts::CartItemsController do
  describe 'POST/create' do
    let(:cart) { create(:cart) }

    before do
      allow(controller).to receive(:current_cart).and_return(cart)
    end

    context 'when cart epmty' do
      let(:product) { create(:product) }
      let(:product_option) { create(:product_option, product:, primary: false) }
      let!(:product_option_value) { create(:product_option_value, product_option:, price: 10) }

      it 'creates a new cart_item' do
        post :create,
             params: { cart_item: { cartable_id: product.id,
                                    cart_item_option_values_attributes: { '0' => { product_option_value_id: product_option_value.id } } } }

        cart.reload
        cart_item = cart.cart_items.last

        expect(cart_item.quantity).to eq(1)
        expect(cart_item.cartable).to eq(product)
        expect(cart_item.cart_item_option_values.last.product_option_value).to eq(product_option_value)
        expect(cart.total_price).to eq(10)
      end
    end

    context 'when cart has more than one cart item' do
      let(:product_first) { create(:product) }
      let(:product_second) { create(:product) }
      let(:product_option_size) { create(:product_option, product: product_first, primary: false) }
      let!(:product_option_value_first) { create(:product_option_value, product_option: product_option_size, price: 10) }
      let!(:product_option_value_second) { create(:product_option_value, product_option: product_option_size, price: 20) }
      let!(:product_option_value_third) { create(:product_option_value, product_option: product_option_size, price: 30) }
      let!(:cart_item_first) { create(:cart_item, cart:, cartable_id: product_first.id, cartable_type: product_first.class.name, quantity: 3) }
      let!(:cart_item_second) { create(:cart_item, cart:, cartable_id: product_second.id, cartable_type: product_second.class.name, quantity: 2) }
      let(:cart_item_option_value_first) do
        create(:cart_item_option_value, cart_item_id: cart_item_first.id, product_option_value_id: product_option_value_first.id)
      end
      let(:cart_item_option_value_second) do
        create(:cart_item_option_value, cart_item_id: cart_item_second.id, product_option_value_id: product_option_value_second.id)
      end

      before do
        cart_item_option_value_first
        cart_item_option_value_second
      end

      it 'creates a new cart_item' do
        expect do
          post :create,
               params: { cart_item: { cartable_id: product_first.id,
                                      cart_item_option_values_attributes: { '0' => { product_option_value_id: product_option_value_third.id } } } }
        end.to change { cart.reload.cart_items.count }.from(2).to(3)

        expect(cart.cart_items.first.cartable).to eq(cart.reload.cart_items.last.cartable)
        expect(cart.cart_items.count).to eq(3)
        expect(cart.total_price).to eq(100) # product_option_value_first * 3 + product_option_value_secon * 2  + product_option_value_third * 1
      end
    end
  end

  describe 'PATCH/update_quantity' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:product_option_size) { create(:product_option, product:, primary: false) }
    let!(:product_option_value) { create(:product_option_value, product_option: product_option_size, price: 10) }
    let!(:cart_item) { create(:cart_item, cart:, cartable_id: product.id, cartable_type: product.class.name, quantity: 3) }
    let(:cart_item_option_value) do
      create(:cart_item_option_value, cart_item_id: cart_item.id, product_option_value_id: product_option_value.id)
    end

    before do
      allow(controller).to receive(:current_cart).and_return(cart)
      cart_item_option_value
    end

    context 'when plus cart item' do
      it 'updates cart_item quantity' do
        expect do
          patch :update_quantity, params: { id: cart_item.id, operation: '+' }
        end.to change { cart_item.reload.quantity }.from(3).to(4)
           .and change { cart.reload.total_price }.from(30).to(40)
      end
    end

    context 'when minus cart item' do
      it 'updates cart_item quantity' do
        expect do
          patch :update_quantity, params: { id: cart_item.id, operation: '-' }
        end.to change { cart_item.reload.quantity }.from(3).to(2)
           .and change { cart.reload.total_price }.from(30).to(20)
      end
    end
  end
end
