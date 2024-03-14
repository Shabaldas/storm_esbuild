describe '/printing_orders', type: :request do
  describe 'GET /static_pages/index' do
    let(:user) { create(:user, :admin) }

    before do
      login_as(user, scope: :user)
    end

    context 'when user is not logined' do
      it 'display printing page' do
        get printing_path

        expect(response).to be_successful
        expect(response.body).to include('Printing')
        expect(response.body).to include(printing_path)
        expect(response.body).to include('Service')
        expect(response.body).to include('FDM')
        expect(response.body).to include('SLA')
        expect(response.body).to include('DLP')
        expect(response.body).to include('Price')
        expect(response.body).to include('Quantity')
        expect(response.body).to include('Layer height')
      end
    end

    context 'when printing portfolio present' do
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

      it 'display printing page with printing portfolio' do
        get printing_path
        expect(response).to be_successful
        expect(response.body).to include(printing_portfolio_active.name)
        expect(response.body).not_to include(printing_portfolio_inactive.name)
        expect(response.body).not_to include(modeling_portfolio_active.name)
        expect(response.body).not_to include(modeling_portfolio_inactive.name)
        expect(response.body).not_to include(rendering_portfolio_active.name)
        expect(response.body).not_to include(rendering_portfolio_inactive.name)
      end
    end
  end

  describe 'POST /printing_orders/create' do
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

      context 'without attached files' do
        it 'create printing order' do
          expect do
            post printing_orders_path, params: {
              printing_order: {
                first_name: 'John',
                last_name: 'Doe',
                email: 'example@example.com',
                phone_number: '+380976404050',
                link_to_model: 'https://www.thingiverse.com/thing:2789086',
                comment: 'Test comment'
              }
            }
          end.to change(PrintingOrder, :count).by(1)

          printing_order = PrintingOrder.last
          expect(printing_order.first_name).to eq('John')
          expect(printing_order.last_name).to eq('Doe')
          expect(printing_order.email).to eq('example@example.com')
          expect(printing_order.phone_number).to eq('+380976404050')
          expect(printing_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
          expect(printing_order.comment).to eq('Test comment')
        end
      end

      context 'with attached files' do
        let(:attachment_file_name) { './spec/fixtures/files/3d_stl_model.stl' }
        let(:params) do
          {
            printing_order: {
              first_name: 'John',
              last_name: 'Doe',
              email: 'example@example.com',
              phone_number: '+380976404050',
              link_to_model: 'https://www.thingiverse.com/thing:2789086',
              comment: 'Test comment',
              files: [
                fixture_file_upload(attachment_file_name)
              ]
            }
          }
        end

        it 'create printing order' do
          expect do
            post(printing_orders_path, params:)
          end.to change(PrintingOrder, :count).by(1)
             .and change(ActiveStorage::Attachment, :count).by(1)
             .and change(ActiveStorage::Blob, :count).by(1)
          printing_order = PrintingOrder.last
          expect(printing_order.files).to be_attached
          expect(printing_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
        end
      end

      context 'when form include XSS attack' do
        it 'sanitize params' do
          expect do
            post printing_orders_path, params: {
              printing_order: {
                first_name: '<script>alert("XSS attack")</script>',
                last_name: '<img src=x onerror=prompt() onclick=prompt()>',
                phone_number: '+380673646510',
                link_to_model: 'https://www.thingiverse.com/thing:2789086',
                comment: '<script>alert("XSS attack")</script>'
              }
            }
          end.to change(PrintingOrder, :count).by(1)

          manual_order = PrintingOrder.last
          expect(manual_order.first_name).to eq('alert("XSS attack")')
          expect(manual_order.last_name).to eq('<img src="x">')
          expect(manual_order.comment).to eq('alert("XSS attack")')
        end
      end
    end

    context 'when invalid data' do
      it 'does not create printing order' do
        expect do
          post printing_orders_path, params: {
            printing_order: {
              first_name: '',
              last_name: 'John',
              link_to_model: 'invalid_link',
              email: 'invalid_phone'
            }
          }
        end.not_to change(PrintingOrder, :count)
      end
    end
  end

  describe 'GET /printing_orders/printing_in_your_city' do
    let!(:city) { create(:city, english_name: 'Ivano-Frankivsk', ukrainian_name: 'Івано-Франківськ') }

    it 'redirect to printing page with city name' do
      get printing_city_path('івано')

      expect(response).to be_successful
      expect(response.body).to include(city.english_name)
      expect(response.body).to include('We provide delivery of 3D printed models across Ukraine')
    end
  end
end
