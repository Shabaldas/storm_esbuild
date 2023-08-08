describe '/dredd/printing_orders', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/printing_orders' do
    it 'displays all printing orders' do
      get dredd_printing_orders_path

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
    end
  end

  describe 'PUT /dredd/printing_orders/:id' do
    let(:printing_order) { create(:printing_order) }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    let(:params) do
      {
        printing_order: {
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
      printing_order
    end

    it 'updates printing order' do
      expect do
        put(dredd_printing_order_path(printing_order), params:)
      end.to change { printing_order.reload.status }.from('unpaid').to('paid')

      printing_order.reload
      expect(printing_order.first_name).to eq('John')
      expect(printing_order.last_name).to eq('Doe')
      expect(printing_order.email).to eq('example@example.com')
      expect(printing_order.phone_number).to eq('+380976404050')
      expect(printing_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
      expect(printing_order.comment).to eq('Test comment')
      expect(printing_order.status).to eq('paid')
    end
  end

  describe 'DELETE /dredd/printing_orders/:id' do
    let(:printing_order) { create(:printing_order) }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      printing_order
    end

    it 'deletes printing order' do
      expect { delete dredd_printing_order_path(printing_order) }.to change(PrintingOrder, :count).by(-1)
    end
  end
end
