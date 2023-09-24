describe '/dredd/accountings', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/accountings' do
  end

  describe 'GET /dredd/accountings/montly' do
  end
end
