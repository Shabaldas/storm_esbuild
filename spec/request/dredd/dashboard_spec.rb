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
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      order_first
      order_second
      feedback_call
      manual_order
    end

    it 'display admin dashboard' do
      get dredd_dashboard_path

      expect(response).to be_successful
      expect(response.body).to include('Admin Dashboard')
      expect(response.body).to include('Feedback Calls')
      expect(response.body).to include('Manual Orders')
      expect(response.body).to include('Printing Orders')
      expect(response.body).to include('Rendering Orders')
      expect(response.body).to include('Modeling Orders')
      expect(response.body).to include('Internet Orders')
      expect(response.body).to include('Users count')
      expect(response.body).to include('New feedback call')
      expect(response.body).to include('Portfolios')
      expect(response.body).to include('Accountings')
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
