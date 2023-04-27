describe Admin::ProductHelper do
  describe '#product_categories_for_select' do
    delegate :product_categories_for_select, to: :helper

    let!(:product_category_first) { create(:product_category, name: 'Home') }
    let!(:product_category_second) { create(:product_category, name: 'Design') }

    it 'returns product categories for select' do
      expect(product_categories_for_select).to eq(
        [
          ['Home', product_category_first.id],
          ['Design', product_category_second.id]
        ]
      )
    end
  end
end
