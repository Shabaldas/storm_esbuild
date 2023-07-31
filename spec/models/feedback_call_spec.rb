RSpec.describe FeedbackCall do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone_number) }
  end

  describe 'callbacks' do
    describe 'after_create' do
      let(:feedback_call) { build(:feedback_call, phone_number: '+380673646509') }

      it 'calls #send_telegram_message' do
        stub_request(:post, /api.telegram.org/).to_return(status: 200, body: '', headers: {})
        feedback_call.save

        expect(feedback_call.phone_number).to eq('+380673646509')
      end
    end
  end
end
