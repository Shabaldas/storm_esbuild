describe '/print_model', type: :request do
  describe 'GET /index' do
    context 'when user admin' do
      let(:user) { create(:user, :admin) }

      before do
        login_as(user, scope: :user)
      end

      it 'dispaly calculators page' do
        get calculator_path

        expect(response).to be_successful
        expect(response.body).to include('Main')
        expect(response.body).to include('Store')
        expect(response.body).to include('Calculator')
      end
    end

    context 'when user not admin' do
      let(:user) { create(:user) }

      before do
        login_as(user, scope: :user)
      end

      it 'not dispaly calculators page' do
        get calculator_path

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('Main')
        expect(response.body).not_to include('Store')
        expect(response.body).not_to include('Calculator')
      end
    end
  end
end
