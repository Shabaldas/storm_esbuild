describe '/dredd/product_categories', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/feedback_cals' do
    let(:feedback_call_first) { create(:feedback_call, phone_number: '+380976404050', processed: true) }
    let(:feedback_call_second) { create(:feedback_call, phone_number: '+380976404050') }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      feedback_call_second
      feedback_call_first
    end

    it 'display all feedback_calls' do
      get dredd_feedback_calls_path

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

  describe 'PUT /dredd/feedback_calls/:id' do
    let(:feedback_call) { create(:feedback_call, phone_number: '+380976404050') }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      feedback_call
    end

    it 'update feedback_call' do
      put dredd_feedback_call_path(feedback_call), params: { feedback_call: { processed: true } }

      expect(response).to redirect_to(dredd_feedback_calls_path)
      follow_redirect!
      expect(response.body).to include('Feedback call was successfully updated.')
    end
  end

  describe 'DELETE /dredd/feedback_calls/:id' do
    let(:feedback_call) { create(:feedback_call, phone_number: '+380976404050') }
    let(:stubed_request) do
      stub_request(:post, /api.telegram.org/)
        .and_return(status: 200, body: '', headers: {})
    end

    before do
      stubed_request
      feedback_call
    end

    it 'destroy feedback_call' do
      delete dredd_feedback_call_path(feedback_call)

      expect(response).to redirect_to(dredd_feedback_calls_path)
      follow_redirect!
      expect(response.body).to include('Feedback call was successfully destroyed.')
    end
  end
end
