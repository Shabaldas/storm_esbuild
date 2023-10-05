describe '/dredd/costs', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'DELETE /dredd/costs/:id' do
    let(:cost_first) { create(:cost) }
    let(:cost_second) { create(:cost) }

    before do
      cost_first
      cost_second
    end

    context 'when format html' do
      it 'deletes the manual order' do
        expect do
          delete dredd_cost_path(cost_first, params: { month_date: Time.current.strftime('%-m/%Y') })
        end.to change(Cost, :count).by(-1)
        expect(response).to redirect_to(monthly_dredd_accountings_path(date: Time.current.strftime('%-m/%Y')))
        follow_redirect!
        expect(response.body).to include('Cost was successfully destroyed.')
      end
    end

    context 'when format turbo_stream' do
      it 'deletes the manual order' do
        expect do
          delete dredd_cost_path(cost_first, params: { month_date: Time.current.strftime('%-m/%Y') }), as: :turbo_stream
        end.to change(Cost, :count).by(-1)
        expect(response).to be_successful
        expect(response.body).to include('Cost was successfully destroyed.')
        expect(response.body).to include('<turbo-stream action="remove')
        expect(response.body).to include('<turbo-stream action="prepend')
      end
    end
  end
end
