describe '/modeling_orders', type: :request do
  describe 'GET /modeling_orders/index' do
    let(:user) { create(:user, :admin) }

    before do
      login_as(user, scope: :user)
    end

    context 'when user is not logined' do
      include_context 'when placeholders present'

      it 'display placeholder modeling page' do
        get modeling_path

        expect(response).to be_successful
        expect(response.body).not_to include('Service')
        expect(response.body).to include(modeling_path)
        expect(response.body).to include(title_placeholder)
        expect(response.body).to include(long_placeholder)
        expect(response.body).not_to include(big_picture_placeholder)
      end
    end
  end

  describe 'GET /modeling_orders/lazy_index' do
    let(:user) { create(:user, :admin) }

    before do
      login_as(user, scope: :user)
    end

    context 'when user is not logined' do
      it 'display modeling page' do
        get modeling_lazy_index_path

        expect(response).to be_successful
        expect(response.body).to include('Modeling')
        expect(response.body).to include(modeling_path)
        expect(response.body).to include('Service')
      end
    end

    context 'when modeling portfolio present' do
      let(:modeling_portfolio_active) { create(:portfolio, name: 'ModelingActive', portfolio_type: :modeling, status: :active) }
      let(:modeling_portfolio_inactive) { create(:portfolio, name: 'ModelingInctive', portfolio_type: :modeling, status: :inactive) }
      let(:rendering_portfolio_active) { create(:portfolio, name: 'RenderingActive', portfolio_type: :rendering, status: :active) }
      let(:rendering_portfolio_inactive) { create(:portfolio, name: 'RenderingInctive', portfolio_type: :rendering, status: :inactive) }
      let(:printing_portfolio_active) { create(:portfolio, name: 'PrintingActive', portfolio_type: :printing, status: :active) }
      let(:printing_portfolio_inactive) { create(:portfolio, name: 'PrintingInctive', portfolio_type: :printing, status: :inactive) }

      before do
        modeling_portfolio_active
        modeling_portfolio_inactive
        rendering_portfolio_active
        rendering_portfolio_inactive
        printing_portfolio_active
        printing_portfolio_inactive
      end

      it 'display modeling page with modeling portfolio' do
        get modeling_lazy_index_path

        expect(response).to be_successful
        expect(response.body).not_to include(printing_portfolio_active.name)
        expect(response.body).not_to include(printing_portfolio_inactive.name)
        expect(response.body).to include(modeling_portfolio_active.name)
        expect(response.body).not_to include(modeling_portfolio_inactive.name)
        expect(response.body).not_to include(rendering_portfolio_active.name)
        expect(response.body).not_to include(rendering_portfolio_inactive.name)
      end
    end
  end

  describe 'POST /modeling_orders/create' do
    context 'when valid data' do
      let(:stubed_request) do
        stub_request(:post, /api.telegram.org/)
          .and_return(status: 200, body: '', headers: {})
      end
      let(:telegram_api_double) { instance_double(Telegram::Bot::Api) }
      let(:phone_number) { '+380673646509' }

      before do
        stubed_request
        allow(Telegram::Bot::Api).to receive(:new).and_return(telegram_api_double)
        allow(telegram_api_double).to receive(:call)
      end

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
