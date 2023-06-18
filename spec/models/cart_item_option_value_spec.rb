RSpec.describe CartItemOptionValue do
  describe 'associations' do
    it { is_expected.to belong_to(:product_option_value) }
  end
end
