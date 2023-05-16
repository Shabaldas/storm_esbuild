RSpec.describe ProductOptionValue do
  describe 'associations' do
    it { is_expected.to belong_to(:product_option).inverse_of(:product_option_values) }
    it { is_expected.to belong_to(:option_value).inverse_of(:product_option_values) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:price) }
  end
end
