RSpec.describe 'Products', type: :request do
  describe 'GET /index' do
    context 'when no filters specified and products count more than limit' do
      before do
        create_list(:product_category, 5, :with_children) do |category, index|
          create_list(:product_category, 5, :with_products, parent: category.children[index])
        end
        get '/v1/products'
      end

      xit 'returns all product with has_more option' do # rubocop:disable RSpec/PendingWithoutReason
        expect(json_response[:data].count).to eq(50)
        expect(json_response[:has_more]).to be(true)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when filter before specific id' do
      let!(:before_product) { create(:product) }

      before do
        create_list(:product_category, 5, :with_children) do |category, index|
          create_list(:product_category, 5, :with_products, parent: category.children[index])
        end
        get '/v1/products', params: { before: before_product.id }
      end

      xit 'returns all product with after option' do # rubocop:disable RSpec/PendingWithoutReason
        expect(response).to have_http_status(:success)
        expect(json_response[:data].pluck(:id).map(&:to_i)).to all(be < before_product.id)
      end
    end

    context 'when filter after specific id' do
      let!(:after_product) { create(:product) }

      before do
        create_list(:product_category, 5, :with_children) do |category, index|
          create_list(:product_category, 5, :with_products, parent: category.children[index])
        end
        get '/v1/products', params: { after: after_product.id }
      end

      xit 'returns all product with after option' do # rubocop:disable RSpec/PendingWithoutReason
        expect(response).to have_http_status(:success)
        expect(json_response[:data].pluck(:id).map(&:to_i)).to all(be > after_product.id)
      end
    end
  end
end
