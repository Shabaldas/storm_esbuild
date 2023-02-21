RSpec.describe Product do
  describe 'associations' do
    it { is_expected.to belong_to(:product_category) }
    it { is_expected.to have_many(:product_options).dependent(:destroy) }
    it { is_expected.to have_many(:options).through(:product_options) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values([:inactive, :active]) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
