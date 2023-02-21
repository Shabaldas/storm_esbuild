RSpec.describe Option do
  describe 'associations' do
    it { is_expected.to have_many(:option_values).dependent(:destroy) }
    it { is_expected.to have_many(:product_options).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
