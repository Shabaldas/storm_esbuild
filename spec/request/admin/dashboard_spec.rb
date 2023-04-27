describe '/admin', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /admin' do
    it 'display admin dashboard' do
      get admin_dashboard_path
      expect(response).to be_successful
      expect(response.body).to include('Admin Dashboard')
      expect(response.body).to include('Products')
      expect(response.body).to include('Product Categories')
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
