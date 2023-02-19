RSpec.describe 'ProductCategories', type: :request do
  describe 'GET /index' do
    context 'when no filters specified' do
      before do
        create_list(:product_category, 2, :with_parent)
        get '/v1/product_categories'
      end

      it 'returns all product categories' do
        expect(json_response.count).to eq(2)
        expect(ProductCategory.count).to eq(4)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
