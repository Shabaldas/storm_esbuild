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
end
