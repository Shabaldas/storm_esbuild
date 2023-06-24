describe '/products', type: :request do
  describe 'GET /index' do
    context 'when products and categories are presents' do
      let(:product_category_with_parrent) { create(:product_category, :with_parent, :with_products) }

      before do
        product_category_with_parrent
      end

      it 'renders a successful response' do
        get products_path

        expect(Product.count).to eq(3)
        expect(response.body).to include('Head')
        expect(response.body).to include('Store')
        expect(response.body).to include('Categories')
        expect(response.body).to include('Search')
        expect(response).to be_successful
      end
    end

    context 'when products not present' do
      it 'display empty products message' do
        get products_path

        expect(Product.count).to eq(0)
        expect(response.body).to include('Head')
        expect(response.body).to include('Store')
        expect(response.body).to include('Categories')
        expect(response.body).to include('Search')
        expect(response.body).to include('No products at the moment')
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /show' do
    let(:product_category) { create(:product_category, :with_parent) }
    let(:product) { create(:product, product_category:) }
    let(:option) { create(:option, measurement: 'mm') }
    let(:product_option) { create(:product_option, option:, product:) }
    let(:product_option_value) { create(:product_option_value, product_option:) }

    before do
      product_option_value
    end

    it 'redirect to product page' do
      get product_path(product)

      expect(response).to be_successful
      expect(response.body).to include(product.name)
      expect(response.body).to include(product.product_category.name)
      expect(response.body).to include(product.price.to_s)
      expect(response.body).to include(url_for(product.main_picture))
      expect(response.body).to include(carts_cart_items_path)
      expect(response.body).to include('Color')
      expect(response.body).to include('Head')
      expect(response.body).to include('Store')
      expect(response.body).to include('Add to basket')
      expect(response.body).to include('Back to shop')
      expect(response.body).to include('Other products')
    end
  end
end
