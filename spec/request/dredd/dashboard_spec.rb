describe '/dredd', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd' do
    let(:order_first) { create(:order, :unpaid) }
    let(:order_second) { create(:order, :unpaid) }
    let(:feedback_call) { create(:feedback_call, phone_number: '+380976404050') }
    let(:manual_order) { create(:manual_order) }

    before do
      order_first
      order_second
      feedback_call
      manual_order
    end

    it 'display admin dashboard' do
      get dredd_dashboard_path

      expect(response).to be_successful
      expect(response.body).to include('Admin Dashboard')
      expect(response.body).to include('Products')
      expect(response.body).to include('Product Categories')
      expect(response.body).to include('Feedback Calls')
      expect(response.body).to include('Manual Orders')
      expect(response.body).to include('Internet Orders')
      expect(response.body).to include('Users count')
      expect(response.body).to include('New feedback call')
    end

    context 'when user is not admin' do
      let(:user) { create(:user) }

      it 'redirect to root path' do
        get dredd_dashboard_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
      end
    end
  end
end
