describe '/dredd/modeling_orders', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/modeling_orders' do
    let(:modeling_order) { create(:modeling_order) }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      modeling_order
    end

    it 'displays all modeling orders' do
      get dredd_modeling_orders_path

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
      expect(response.body).to include(dredd_modeling_order_path(modeling_order))
      expect(response.body).to include(edit_dredd_modeling_order_path(modeling_order))
    end
  end

  describe 'PUT /dredd/modeling_orders/:id' do
    let(:modeling_order) { create(:modeling_order) }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    let(:params) do
      {
        modeling_order: {
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
      modeling_order
    end

    it 'updates rendering order' do
      expect do
        put(dredd_modeling_order_path(modeling_order), params:)
      end.to change { modeling_order.reload.status }.from('unpaid').to('paid')

      modeling_order.reload
      expect(modeling_order.first_name).to eq('John')
      expect(modeling_order.last_name).to eq('Doe')
      expect(modeling_order.email).to eq('example@example.com')
      expect(modeling_order.phone_number).to eq('+380976404050')
      expect(modeling_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
      expect(modeling_order.comment).to eq('Test comment')
      expect(modeling_order.status).to eq('paid')
    end
  end

  describe 'DELETE /dredd/modeling_orders/:id' do
    let(:modeling_order) { create(:modeling_order) }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      modeling_order
    end

    it 'deletes modeling order' do
      expect { delete dredd_modeling_order_path(modeling_order) }.to change(ModelingOrder, :count).by(-1)
    end
  end
end
