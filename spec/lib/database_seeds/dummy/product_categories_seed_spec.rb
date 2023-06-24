RSpec.describe DatabaseSeeds::Dummy::ProductCategoriesSeed do
  describe '#execute' do
    context 'when executing seed' do
      before { described_class.new.execute }

      it 'creates unique ids for categories' do
        category_ids = ProductCategory.all.pluck(:id)
        expect(category_ids.size).to eq(category_ids.uniq.size)
      end
    end
  end
end
