RSpec.describe Cart do
  describe 'associations' do
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
  end
end
