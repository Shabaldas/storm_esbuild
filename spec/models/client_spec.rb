RSpec.describe Client do
  describe '.associations' do
    it { is_expected.to have_many(:manual_orders) }
  end

  describe '.validations' do
    it { is_expected.to validate_presence_of(:first_name) }
  end
end
