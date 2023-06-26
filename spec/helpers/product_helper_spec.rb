describe ProductHelper do
  describe '#size_option_value_for_select' do
    delegate :size_option_value_for_select, to: :helper

    let!(:option) { create(:option, measurement: 'mm') }
    let!(:option_value_first) { create(:option_value, option:, value: 'small') }
    let!(:option_value_second) { create(:option_value, option:, value: 'medium') }

    it 'returns option values for select' do
      expect(size_option_value_for_select).to eq(
        [
          ['small', option_value_first.id],
          ['medium', option_value_second.id]
        ]
      )
    end
  end

  describe '#products_count_for_parent_category' do
    delegate :products_count_for_parent_category, to: :helper

    let!(:product_category_parent) { create(:product_category, name: 'Parent') }
    let!(:product_category_first) { create(:product_category, name: 'Home', parent: product_category_parent) }
    let!(:product_category_second) { create(:product_category, name: 'Design', parent: product_category_parent) }
    let!(:product_first) { create(:product, product_category: product_category_first) }
    let!(:product_second) { create(:product, product_category: product_category_second) }

    it 'returns all products count for parent category' do
      expect(products_count_for_parent_category(product_category_parent)).to eq(2)
    end
  end
end
