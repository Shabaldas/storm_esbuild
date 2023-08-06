describe '/dredd/modeling_orders', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/modeling_orders' do
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
