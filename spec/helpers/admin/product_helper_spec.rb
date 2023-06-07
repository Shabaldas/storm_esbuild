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

  describe '#classes_for_flash' do
    delegate :classes_for_flash, to: :helper

    context 'when flash type is error' do
      it 'returns bg-danger' do
        expect(classes_for_flash(:error)).to eq('bg-danger')
      end
    end

    context 'when flash type is not error' do
      it 'returns bg-primary' do
        expect(classes_for_flash(:notice)).to eq('bg-primary')
      end
    end
  end

  describe '#color_option_value_for_select' do
    delegate :color_option_value_for_select, to: :helper

    let!(:option) { create(:option, measurement: 'color') }
    let!(:option_value_first) { create(:option_value, option:, value: 'red') }
    let!(:option_value_second) { create(:option_value, option:, value: 'blue') }

    it 'returns option values for select' do
      expect(color_option_value_for_select).to eq(
        [
          ['red', option_value_first.id],
          ['blue', option_value_second.id]
        ]
      )
    end
  end

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
end
