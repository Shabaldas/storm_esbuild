RSpec.describe FeedbackCall do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone_number) }
  end
end
