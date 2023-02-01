RSpec.describe ProductCategory, type: :model do
  describe '.create category with parent category' do
    let(:product_category) { create(:product_category, :with_parent) }

    it 'return parent category id' do
      expect(product_category.parent.id.to_s).to eq(product_category.ancestry)
    end
  end
end
