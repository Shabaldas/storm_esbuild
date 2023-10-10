describe '/rendering_orders', type: :request do
  describe 'GET /rendering_orders/index' do
    let(:user) { create(:user, :admin) }

    before do
      login_as(user, scope: :user)
    end

    context 'when user is not logined' do
      include_context 'when placeholders present'

      it 'display placeholder rendering page' do
        get rendering_path

        expect(response).to be_successful
        expect(response.body).not_to include('Service')
        expect(response.body).to include(modeling_path)
        expect(response.body).to include(title_placeholder)
        expect(response.body).to include(long_placeholder)
        expect(response.body).not_to include(big_picture_placeholder)
      end
    end
  end

  describe 'GET /rendering_orders/lazy' do
    context 'when user is not logined' do
      it 'display lazy rendering page' do
        get rendering_lazy_path

        expect(response).to be_successful
        expect(response.body).to include('Rendering')
        expect(response.body).to include(rendering_path)
        expect(response.body).to include('Service')
      end
    end

    context 'when rendering portfolio present' do
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

      it 'display rendering page with rendering portfolio' do
        get rendering_lazy_path

        expect(response).to be_successful
        expect(response.body).not_to include(printing_portfolio_active.name)
        expect(response.body).not_to include(printing_portfolio_inactive.name)
        expect(response.body).not_to include(modeling_portfolio_active.name)
        expect(response.body).not_to include(modeling_portfolio_inactive.name)
        expect(response.body).to include(rendering_portfolio_active.name)
        expect(response.body).not_to include(rendering_portfolio_inactive.name)
      end
    end
  end

  describe 'POST /rendering_orders/create' do
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
