describe '/dredd/scanning_orders', type: :request do
  let(:user) { create(:user, :admin) }
  let(:telegram_api_double) { instance_double(Telegram::Bot::Api) }
  let(:phone_number) { '1234567890' }

  before do
    login_as(user, scope: :user)
    allow(Telegram::Bot::Api).to receive(:new).and_return(telegram_api_double)
    allow(telegram_api_double).to receive(:call)
  end

  describe 'GET /dredd/scanning_orders' do
    let(:scanning_order) { create(:scanning_order) }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      scanning_order
    end

    it 'displays all scanning orders' do
      get dredd_scanning_orders_path

      expect(response).to be_successful
      expect(response.body).to include('ID')
      expect(response.body).to include('Full name')
      expect(response.body).to include('Phone number')
      expect(response.body).to include('Email')
      expect(response.body).to include('Status')
      expect(response.body).to include('Price')
      expect(response.body).to include('Deadline')
      expect(response.body).to include('Comment')
      expect(response.body).to include('Actions')
      expect(response.body).to include(dredd_scanning_order_path(scanning_order))
      expect(response.body).to include(edit_dredd_scanning_order_path(scanning_order))
    end
  end

  describe 'PUT /dredd/scanning_orders/:id' do
    let(:scanning_order) { create(:scanning_order) }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    let(:params) do
      {
        scanning_order: {
          first_name: 'John',
          last_name: 'Doe',
          email: 'example@example.com',
          phone_number: '+380976404050',
          link_to_model: 'https://www.thingiverse.com/thing:2789086',
          comment: 'Test comment',
          status: 'paid'
        }
      }
    end

    before do
      stubed_request
      scanning_order
    end

    it 'updates scanning order' do
      expect do
        put(dredd_scanning_order_path(scanning_order), params:)
      end.to change { scanning_order.reload.status }.from('unpaid').to('paid')

      scanning_order.reload
      expect(scanning_order.first_name).to eq('John')
      expect(scanning_order.last_name).to eq('Doe')
      expect(scanning_order.email).to eq('example@example.com')
      expect(scanning_order.phone_number).to eq('+380976404050')
      expect(scanning_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
      expect(scanning_order.comment).to eq('Test comment')
      expect(scanning_order.status).to eq('paid')
    end
  end

  describe 'DELETE /dredd/scanning_orders/:id' do
    let(:scanning_order) { create(:scanning_order) }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      scanning_order
    end

    it 'deletes scanning order' do
      expect { delete dredd_scanning_order_path(scanning_order) }.to change(ScanningOrder, :count).by(-1)
    end
  end
end
