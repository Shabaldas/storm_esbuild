RSpec.describe DatabaseSeeds::Dummy::ProductCategoriesSeed do
  describe '#execute' do
    it 'creates ten product categories with child categories' do
      expect do
        described_class.new.execute
      end.to change(ProductCategory, :count).by(10)

      ProductCategory.where(id: 1..5).each do |category|
        expect(category.children.count).to eq(1)
        expect(category.ancestry).to be_nil
      end

      ProductCategory.where(id: 6..10).each do |category| # rubocop:disable RSpec/IteratedExpectation
        expect(category).to have_parent
      end
    end
  end
end
