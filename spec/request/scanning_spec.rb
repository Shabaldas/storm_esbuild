describe '/scanning_orders', type: :request do
  describe 'GET /scanning_orders/index' do
    let(:user) { create(:user, :admin) }

    before do
      login_as(user, scope: :user)
    end

    context 'when user is not logined' do
      include_context 'when placeholders present'

      it 'display placeholder scanning page' do
        get scanning_path

        expect(response).to be_successful
        expect(response.body).not_to include('Service')
        expect(response.body).to include(modeling_path)
        expect(response.body).to include(title_placeholder)
        expect(response.body).to include(long_placeholder)
        expect(response.body).not_to include(big_picture_placeholder)
      end
    end
  end

  describe 'GET /scanning_orders/lazy' do
    context 'when user is not logined' do
      it 'display lazy scanning page' do
        get scanning_lazy_path

        expect(response).to be_successful
        expect(response.body).to include('Scanning')
        expect(response.body).to include(scanning_path)
        expect(response.body).to include('Service')
      end
    end

    context 'when scanning portfolio present' do
      let(:modeling_portfolio_active) { create(:portfolio, name: 'ModelingActive', portfolio_type: :modeling, status: :active) }
      let(:modeling_portfolio_inactive) { create(:portfolio, name: 'ModelingInctive', portfolio_type: :modeling, status: :inactive) }
      let(:rendering_portfolio_active) { create(:portfolio, name: 'RenderingActive', portfolio_type: :rendering, status: :active) }
      let(:rendering_portfolio_inactive) { create(:portfolio, name: 'RenderingInctive', portfolio_type: :rendering, status: :inactive) }
      let(:scanning_portfolio_active) { create(:portfolio, name: 'ScanningActive', portfolio_type: :scanning, status: :active) }
      let(:scanning_portfolio_inactive) { create(:portfolio, name: 'ScanningInctive', portfolio_type: :scanning, status: :inactive) }
      let(:printing_portfolio_active) { create(:portfolio, name: 'PrintingActive', portfolio_type: :printing, status: :active) }
      let(:printing_portfolio_inactive) { create(:portfolio, name: 'PrintingInctive', portfolio_type: :printing, status: :inactive) }

      before do
        modeling_portfolio_active
        modeling_portfolio_inactive
        rendering_portfolio_active
        rendering_portfolio_inactive
        scanning_portfolio_active
        scanning_portfolio_inactive
        printing_portfolio_active
        printing_portfolio_inactive
      end

      it 'display scanning page with scanning portfolio' do
        get scanning_lazy_path

        expect(response).to be_successful
        expect(response.body).not_to include(printing_portfolio_active.name)
        expect(response.body).not_to include(printing_portfolio_inactive.name)
        expect(response.body).not_to include(modeling_portfolio_active.name)
        expect(response.body).not_to include(modeling_portfolio_inactive.name)
        expect(response.body).not_to include(rendering_portfolio_active.name)
        expect(response.body).not_to include(rendering_portfolio_inactive.name)
        expect(response.body).to include(scanning_portfolio_active.name)
        expect(response.body).not_to include(scanning_portfolio_inactive.name)
      end
    end
  end

  describe 'POST /scanning_orders/create' do
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

      it 'create scanning order' do
        expect do
          post scanning_orders_path, params: {
            scanning_order: {
              first_name: 'John',
              last_name: 'Doe',
              email: 'example@example.com',
              phone_number: '+380976404050',
              link_to_model: 'https://www.thingiverse.com/thing:2789086',
              comment: 'Test comment'
            }
          }
        end.to change(ScanningOrder, :count).by(1)

        scanning_order = ScanningOrder.last
        expect(scanning_order.first_name).to eq('John')
        expect(scanning_order.last_name).to eq('Doe')
        expect(scanning_order.email).to eq('example@example.com')
        expect(scanning_order.phone_number).to eq('+380976404050')
        expect(scanning_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
        expect(scanning_order.comment).to eq('Test comment')
      end
    end

    context 'when invalid data' do
      it 'does not create modeling order' do
        expect do
          post scanning_orders_path, params: {
            scanning_order: {
              first_name: '',
              last_name: 'John',
              link_to_model: 'invalid_link',
              email: 'invalid_phone'
            }
          }
        end.not_to change(ScanningOrder, :count)
      end
    end

    describe 'GET /scanning_orders/scanning_in_your_city' do
      let!(:city) { create(:city, english_name: 'Lviv', ukrainian_name: 'Львів') }

      it 'redirect to printing page with city name' do
        get printing_city_path('львів')

        expect(response).to be_successful
        expect(response.body).to include(city.english_name)
      end
    end
  end
end
