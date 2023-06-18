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

  describe '#size_value_for_select' do
    delegate :size_value_for_select, to: :helper

    let(:product) { create(:product) }
    let(:option) { create(:option, measurement: 'mm') }
    let(:product_option) { create(:product_option, product:, option:) }
    let(:option_value_first) { create(:option_value, option:, value: 'small') }
    let(:option_value_second) { create(:option_value, option:, value: 'medium') }
    let(:product_option_value_first) { create(:product_option_value, product_option:, option_value: option_value_first, price: 10) }
    let(:product_option_value_second) { create(:product_option_value, product_option:, option_value: option_value_second, price: 20) }

    before do
      product_option_value_first
      product_option_value_second
    end

    it 'returns option values for select' do
      expect(size_value_for_select(product)).to eq(
        [
          ['small', option_value_first.id, { data: { price: 10.to_f } }],
          ['medium', option_value_second.id, { data: { price: 20.to_f } }]
        ]
      )
    end
  end
end
