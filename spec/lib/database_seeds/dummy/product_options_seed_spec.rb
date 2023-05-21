RSpec.describe DatabaseSeeds::Dummy::ProductOptionsSeed do
  describe '#execute' do
    let!(:size_option) { create(:option, title: 'Size', measurement: :mm) }
    let!(:color_option) { create(:option, title: 'Color', measurement: :color) }
    let(:color_option_value) { create(:option_value, option: color_option) }
    let(:size_option_value) { create(:option_value, option: size_option) }
    let(:products) { create_list(:product, 45) }

    before do
      products
      color_option_value
      size_option_value
    end

    context 'when executing seed' do
      before { described_class.new.execute }

      it 'creates 28 products with color option' do
        expect(Product.joins(:product_options).where(product_options: { option: color_option }).count).to eq(28)
      end

      it 'creates 30 products with size option' do
        expect(Product.joins(:product_options).where(product_options: { option: size_option }).count).to eq(37)
      end
    end
  end
end