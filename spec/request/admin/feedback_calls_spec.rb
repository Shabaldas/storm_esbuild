describe '/admin/product_categories', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /admin/feedback_cals' do
    let!(:feedback_call_first) { create(:feedback_call, phone_number: '+380123456789', processed: true) }
    let!(:feedback_call_second) { create(:feedback_call, phone_number: '+380987654321') }

    it 'display all feedback_calls' do
      get admin_feedback_calls_path

      expect(response).to be_successful
      expect(response.body).to include('ID')
      expect(response.body).to include('PHONE NUMBER')
      expect(response.body).to include('PROCESSED')
      expect(response.body).to include('CREATED AT')
      expect(response.body).to include(feedback_call_first.id.to_s)
      expect(response.body).to include(feedback_call_first.phone_number)
      expect(response.body).to include(feedback_call_second.id.to_s)
      expect(response.body).to include(feedback_call_second.phone_number)
    end
  end
end