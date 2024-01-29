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
      let(:worker) { create(:worker) }

      before do
        user_first
        user_second
        user_third
        worker
      end

      it 'display all products' do
        stub_request(:post, /api.telegram.org/).to_return(status: 200, body: '', headers: {})
        get dredd_users_path

        expect(response).to be_successful
        expect(response.body).to include('ADMINS')
        expect(response.body).to include('CUSTOMERS')
        expect(response.body).to include('WORKERS')
        expect(response.body).to include('ID')
        expect(response.body).to include('FULL NAME')
        expect(response.body).to include('EMAIL')
        expect(response.body).to include('PHONE')
        expect(response.body).to include('CREATED AT')
        expect(response.body).to include(user_first.id.to_s)
        expect(response.body).to include(user_second.id.to_s)
        expect(response.body).to include(user_third.id.to_s)
        expect(response.body).to include(worker.id.to_s)
        expect(response.body).to include(html_escape(user_first.first_name))
        expect(response.body).to include(html_escape(user_second.first_name))
        expect(response.body).to include(html_escape(user_third.first_name))
        expect(response.body).to include(html_escape(worker.first_name))
        expect(response.body).to include(html_escape(user_first.last_name))
        expect(response.body).to include(html_escape(user_second.last_name))
        expect(response.body).to include(html_escape(user_third.last_name))
        expect(response.body).to include(html_escape(worker.last_name))
        expect(response.body).to include(user_first.phone)
        expect(response.body).to include(user_second.phone)
        expect(response.body).to include(user_third.phone)
        expect(response.body).to include(worker.nickname)
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
