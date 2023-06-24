RSpec.describe DatabaseSeeds::Dummy::ProductsSeed do
  describe '#execute' do
    let!(:parent_category) { create(:product_category, name: 'Parent category') }
    let!(:child_category) { create(:product_category, name: 'Child category', parent: parent_category) }

    context 'when executing seed' do
      before { described_class.new.execute }

      it 'creates 10 products for child category' do
        expect(child_category.products.count).to eq(10)
      end

      it 'creates 5 products for parent category' do
        expect(parent_category.products.count).to eq(0)
      end

      it 'creates unique ids for products' do
        product_ids = Product.all.pluck(:id)
        expect(product_ids.size).to eq(product_ids.uniq.size)
      end
    end
  end
end
