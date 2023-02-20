RSpec.describe Product, type: :model do
  describe '.associations' do
    it { is_expected.to belong_to(:product_category) }
  end

  describe '.enums' do
    it { is_expected.to define_enum_for(:status).with_values([:inactive, :active]) }
  end
end
