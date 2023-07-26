describe PrintingHelper do
  describe '#material_for_select' do
    delegate :material_for_select, to: :helper

    it 'returns option values for select' do
      expect(material_for_select).to eq(
        [
          ["Пластик PLA (від 100 ₴/г)", "/printing?material=PLA"],
          ["Пластик ABS (від 200 ₴/г)", "/printing?material=ABS"]
        ]
      )
    end
  end
end
