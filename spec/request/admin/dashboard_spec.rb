describe '/admin', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /admin' do
    let(:order_first) { create(:order, :unpaid) }
    let(:order_second) { create(:order, :unpaid) }
    let(:feedback_call) { create(:feedback_call, phone_number: '+380123456789') }

    before do
      order_first
      order_second
      feedback_call
    end

    it 'display admin dashboard' do
      get admin_dashboard_path

      expect(response).to be_successful
      expect(response.body).to include('Admin Dashboard')
      expect(response.body).to include('Products')
      expect(response.body).to include('Product Categories')
      expect(response.body).to include('Feedback Calls')
      expect(response.body).to include('Feedback Calls')
      expect(response.body).to include('Orders')
      expect(response.body).to include('Users count')
      expect(response.body).to include('Order count')
      expect(response.body).to include('New feedback call')
      expect(response.body).to include(user.id.to_s)
      expect(response.body).to include(order_first.id.to_s)
      expect(response.body).to include(order_second.id.to_s)
      expect(response.body).to include(feedback_call.id.to_s)
    end

    context 'when user is not admin' do
      let(:user) { create(:user) }

      it 'redirect to root path' do
        get admin_dashboard_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
      end
    end
  end
end
