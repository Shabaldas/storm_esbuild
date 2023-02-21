RSpec.describe ProductCategory do
  describe '.associations' do
    it { is_expected.to have_many(:products).dependent(:destroy) }
  end

  describe '.create category with parent category' do
    let(:product_category) { create(:product_category, :with_parent) }

    it 'return parent category id' do
      expect(product_category.parent.id.to_s).to eq(product_category.ancestry)
    end
  end

  describe '.create category with products' do
    let(:product_category) { create(:product_category, :with_products) }

    it 'return products count' do
      expect(product_category.products.count).to eq(3)
    end
  end
end
