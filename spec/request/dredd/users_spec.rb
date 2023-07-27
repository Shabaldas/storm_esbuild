describe '/dredd/users', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/users' do
    context 'when user is admin' do
      let(:user_first) { create(:user) }
      let(:user_second) { create(:user, role: :admin) }
      let(:user_third) { create(:user) }

      before do
        user_first
        user_second
        user_third
      end

      it 'display all products' do
        get dredd_users_path

        expect(response).to be_successful
        expect(response.body).to include('ADMINS')
        expect(response.body).to include('CUSTOMERS')
        expect(response.body).to include('ID')
        expect(response.body).to include('FULL NAME')
        expect(response.body).to include('EMAIL')
        expect(response.body).to include('PHONE')
        expect(response.body).to include('CREATED AT')
        expect(response.body).to include(user_first.id.to_s)
        expect(response.body).to include(user_second.id.to_s)
        expect(response.body).to include(user_third.id.to_s)
        expect(response.body).to include(user_first.first_name)
        expect(response.body).to include(user_second.first_name)
        expect(response.body).to include(user_third.first_name)
        expect(response.body).to include(user_first.last_name)
        expect(response.body).to include(user_second.last_name)
        expect(response.body).to include(user_third.last_name)
        expect(response.body).to include(user_first.phone)
        expect(response.body).to include(user_second.phone)
        expect(response.body).to include(user_third.phone)
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user) }

      it 'redirect to root path' do
        get dredd_users_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
      end
    end
  end
end