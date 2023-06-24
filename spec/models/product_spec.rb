RSpec.describe Product do
  describe 'associations' do
    it { is_expected.to belong_to(:product_category) }
    it { is_expected.to have_many(:product_options).dependent(:destroy) }
    it { is_expected.to have_many(:options).through(:product_options) }
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
    it { is_expected.to have_many(:carts).through(:cart_items) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values([:inactive, :active]) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }

    it 'only allows png file' do
      product_category = create(:product_category, :with_parent)
      product = build(:product, product_category: product_category)
      product.main_picture = {
        io: File.new('./spec/fixtures/files/dummy.png'),
        filename: 'dummy.png'
      }
      expect(product).to be_valid
    end

    describe 'custom validations' do
      describe '#parent_product_validation' do
        let(:product_category) { create(:product_category) }
        let(:product) { build(:product, product_category: product_category) }

        it 'returns error if product category is parent' do
          expect(product).to be_invalid
          expect(product.errors[:base]).to include('Parent category can not have products')
        end
      end
    end
  end

  describe '#product_colors' do
    let(:product_category) { create(:product_category, :with_parent) }
    let(:product) { create(:product, product_category:) }
    let(:product_option) { create(:product_option, product:, primary: true) }
    let!(:product_option_value) { create(:product_option_value, product_option:) }

    it 'returns product colors' do
      expect(product.product_colors).to eq([product_option_value])
    end
  end

  describe '#product_sizes' do
    let(:product_category) { create(:product_category, :with_parent) }
    let(:product) { create(:product, product_category:) }
    let(:product_option) { create(:product_option, product:, primary: false) }
    let!(:product_option_value) { create(:product_option_value, product_option:) }

    it 'returns product sizes' do
      expect(product.product_sizes).to eq([product_option_value])
    end
  end
end
