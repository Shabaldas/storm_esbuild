describe '/calculators', type: :request do
  describe 'GET /index' do
    context 'when user admin' do
      let(:user) { create(:user, :admin) }

      before do
        login_as(user, scope: :user)
      end

      it 'dispaly calculators page' do
        get calculators_path

        expect(response).to be_successful
        expect(response.body).to include('Head')
        expect(response.body).to include('Store')
        expect(response.body).to include('Calculator')
      end
    end

    context 'when user not admin' do
      let(:user) { create(:user) }

      it 'redirect to root path' do
        get calculators_path

        expect(response).to redirect_to(root_path)
        follow_redirect!
      end
    end
  end
end
