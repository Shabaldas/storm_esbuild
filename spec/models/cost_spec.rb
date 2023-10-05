RSpec.describe Cost do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe '.validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:amount) }
  end
end
