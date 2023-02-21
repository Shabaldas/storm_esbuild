RSpec.describe ProductOption do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:option) }
  end
end
