describe '/products', type: :request do
  describe 'GET /index' do
    context 'when products and categories are presents' do
      let(:product_category_with_children) { create(:product_category, :with_children, :with_products) }
      let(:product_category_with_parrent) { create(:product_category, :with_parent) }

      before do
        product_category_with_children
        product_category_with_parrent
      end

      it 'renders a successful response' do
        get products_path

        expect(Product.count).to eq(3)
        expect(ProductCategory.count).to eq(6)
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
    let(:product) { create(:product) }

    it 'redirect to product page' do
      get product_path(product)

      expect(response.body).to include(product.name)
      expect(response.body).to include(product.price.to_s)
      expect(response.body).to include(cart_add_product_path)
      expect(response.body).to include('Head')
      expect(response.body).to include('Store')
      expect(response.body).to include('Add to cart')
      expect(response).to be_successful
    end
  end
end
