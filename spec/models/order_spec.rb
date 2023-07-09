RSpec.describe Order do
  describe 'associations' do
    it { is_expected.to have_one(:cart).dependent(:destroy) }
  end
end
