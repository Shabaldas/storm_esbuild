
describe 'dredd/costs', type: :request do
  let(:user) { create(:user, :admin) }
  let(:valid_params) { { cost: { name: 'Test Cost', description: 'Test Description', amount: 100, date: Date.today } } }
  let(:invalid_params) { { cost: { name: '', description: 'Test Description', amount: 100, date: Date.today } } }

  before do
    login_as(user, scope: :user)
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new cost' do
        expect do
          post dredd_costs_path, params: valid_params
        end.to change(Cost, :count).by(1)

        expect(response).to redirect_to(monthly_dredd_accountings_path(date: valid_params[:cost][:month_date]))
        expect(flash[:info][:text]).to eq('Cost created')
        expect(flash[:info][:icon]).to eq('success_icon')
      end
    end

    context 'with invalid params' do
      it 'does not create a new cost' do
        expect do
          post dredd_costs_path, params: invalid_params
        end.not_to change(Cost, :count)

        expect(response).to redirect_to(monthly_dredd_accountings_path(date: invalid_params[:cost][:month_date]))
        expect(flash[:error][:text]).to eq('Cost not created')
        expect(flash[:error][:icon]).to eq('attention')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:cost) { create(:cost) }

    it 'deletes the cost' do
      expect do
        delete dredd_cost_path(cost)
      end.to change(Cost, :count).by(-1)

      expect(flash[:info][:text]).to eq('Cost deleted')
      expect(flash[:info][:icon]).to eq('success_icon')
    end
  end
end
