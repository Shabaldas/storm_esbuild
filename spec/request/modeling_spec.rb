describe '/modeling_orders', type: :request do
  describe 'GET /modeling_orders/index' do
    let(:user) { create(:user, :admin) }

    before do
      login_as(user, scope: :user)
    end

    context 'when user is not logined' do
      it 'display modeling page' do
        get modeling_path

        expect(response).to be_successful
        expect(response.body).to include('Modeling')
        expect(response.body).to include(modeling_path)
        expect(response.body).to include('Service')
      end
    end
  end

  describe 'POST /modeling_orders/create' do
    context 'when valid data' do
      it 'create modeling order' do
        expect do
          post modeling_orders_path, params: {
            modeling_order: {
              first_name: 'John',
              last_name: 'Doe',
              email: 'example@example.com',
              phone_number: '+380976404050',
              link_to_model: 'https://www.thingiverse.com/thing:2789086',
              comment: 'Test comment'
            }
          }
        end.to change(ModelingOrder, :count).by(1)

        manual_order = ModelingOrder.last
        expect(manual_order.first_name).to eq('John')
        expect(manual_order.last_name).to eq('Doe')
        expect(manual_order.email).to eq('example@example.com')
        expect(manual_order.phone_number).to eq('+380976404050')
        expect(manual_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
        expect(manual_order.comment).to eq('Test comment')
      end
    end

    context 'when invalid data' do
      it 'does not create modeling order' do
        expect do
          post modeling_orders_path, params: {
            modeling_order: {
              first_name: '',
              last_name: 'John',
              link_to_model: 'invalid_link',
              email: 'invalid_phone'
            }
          }
        end.not_to change(ModelingOrder, :count)
      end
    end
  end
end
