RSpec.describe 'ProductCategories', type: :request do
  describe 'GET /index' do
    context 'when no filters specified' do
      before do
        create_list(:product_category, 2, :with_parent)
        get '/v1/product_categories'
      end

      it 'returns all product categories' do
        expect(json_response[:data].count).to eq(2)
        expect(json_response[:has_more]).to be(false)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when more than default limit' do
      before do
        create_list(:product_category, 30, :with_parent)
        get '/v1/product_categories'
      end

      it 'returns all product categories with has_more option' do
        expect(json_response[:data].count).to eq(10)
        expect(json_response[:has_more]).to be(true)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
