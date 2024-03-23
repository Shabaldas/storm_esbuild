describe '/profiles', type: :request do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /profiles/:id' do
    context 'when user is current user' do
      it 'display the user' do
        get profile_path(user)

        expect(response).to be_successful
        expect(response.body).to include(user.first_name)
        expect(response.body).to include(user.last_name)
        expect(response.body).to include(user.email)
        expect(response.body).to include(user.phone)
      end
    end

    context 'when user is not current user' do
      let!(:user_second) { create(:user) }

      before do
        login_as(user_second, scope: :user)
      end

      it 'redirect to root path' do
        get profile_path(user)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You are not authorized to access this page.')
      end
    end
  end

  describe 'PUT /update_personal_data/:id' do
    let(:params) do
      {
        user: {
          first_name: 'Pupkin',
          last_name: 'Vasa'
        }
      }
    end

    it 'update user personal data' do
      expect do
        put(update_personal_data_path(user), params:, as: :turbo_stream)
        user.reload
      end.to change(User, :count).by(0) # rubocop:disable RSpec/ChangeByZero
          .and change(user, :first_name).from(user.first_name).to('Pupkin')
          .and change(user, :last_name).from(user.last_name).to('Vasa')
      expect(response.body).to include('User was successfully updated.')
    end
  end

  describe 'path /update_password/:id' do
    let(:params) do
      {
        user: {
          password: '111111',
          password_confirmation: '111111'
        }
      }
    end

    let(:params_invalid) do
      {
        user: {
          password: '1111112',
          password_confirmation: '111111'
        }
      }
    end

    it 'update user password' do
      expect do
        patch(update_password_path(user), params:, as: :turbo_stream)
        user.reload
      end.to change(User, :count).by(0) # rubocop:disable RSpec/ChangeByZero
      expect(response.body).to include('User was successfully updated.')
    end

    it 'not update user password' do
      expect do
        patch(update_password_path(user), params: params_invalid, as: :turbo_stream)
        user.reload
      end.to change(User, :count).by(0) # rubocop:disable RSpec/ChangeByZero
      expect(response.body).to include('Doesn&#39;t match password')
    end
  end
end
