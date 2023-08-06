describe '/dredd/rendering_orders', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/rendering_orders' do
    it 'displays all rendering orders' do
      get dredd_rendering_orders_path

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

  describe 'DELETE /dredd/rendering_orders/:id' do
    let(:rendering_order) { create(:rendering_order) }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      rendering_order
    end

    it 'deletes rendering order' do
      expect { delete dredd_rendering_order_path(rendering_order) }.to change(RenderingOrder, :count).by(-1)
    end
  end
end
