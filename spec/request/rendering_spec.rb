describe '/rendering_orders', type: :request do
  describe 'GET /rendering_orders/index' do
    context 'when user is not logined' do
      it 'display rendering page' do
        get rendering_path

        expect(response).to be_successful
        expect(response.body).to include('Rendering')
        expect(response.body).to include(rendering_path)
        expect(response.body).to include('Service')
      end
    end
  end

  describe 'POST /rendering_orders/create' do
    context 'when valid data' do
      it 'create rendering order' do
        expect do
          post rendering_orders_path, params: {
            rendering_order: {
              first_name: 'John',
              last_name: 'Doe',
              email: 'example@example.com',
              phone_number: '+380976404050',
              link_to_model: 'https://www.thingiverse.com/thing:2789086',
              comment: 'Test comment'
            }
          }
        end.to change(RenderingOrder, :count).by(1)

        rendering_order = RenderingOrder.last
        expect(rendering_order.first_name).to eq('John')
        expect(rendering_order.last_name).to eq('Doe')
        expect(rendering_order.email).to eq('example@example.com')
        expect(rendering_order.phone_number).to eq('+380976404050')
        expect(rendering_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
        expect(rendering_order.comment).to eq('Test comment')
      end
    end

    context 'when invalid data' do
      it 'does not create modeling order' do
        expect do
          post rendering_orders_path, params: {
            rendering_order: {
              first_name: '',
              last_name: 'John',
              link_to_model: 'invalid_link',
              email: 'invalid_phone'
            }
          }
        end.not_to change(RenderingOrder, :count)
      end
    end
  end
end
