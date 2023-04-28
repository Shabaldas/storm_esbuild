describe '/admin/products', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /admin/products' do
    let!(:products) { create_list(:product, 2) }

    it 'display all products' do
      get admin_products_path

      expect(response).to be_successful
      expect(response.body).to include('ID')
      expect(response.body).to include('NAME')
      expect(response.body).to include('PRODUCT CATEGORY')
      expect(response.body).to include('STATUS')
      expect(response.body).to include('CREATED AT')
      expect(response.body).to include('Create New Product')
      expect(response.body).to include(products.first.id.to_s)
      expect(response.body).to include(products.first.name)
      expect(response.body).to include(products.first.product_category.name)
      expect(response.body).to include(products.first.status)
      expect(response.body).to include(products.second.id.to_s)
      expect(response.body).to include(products.second.name)
      expect(response.body).to include(products.second.product_category.name)
      expect(response.body).to include(products.second.status)
    end
  end

  describe 'GET /admin/products/:id' do
    let(:product) { create(:product) }

    it 'display product' do
      get admin_product_path(product)

      expect(response).to be_successful
      expect(response.body).to include(product.id.to_s)
      expect(response.body).to include(product.name)
      expect(response.body).to include(product.product_category.name)
      expect(response.body).to include(product.price.to_i.to_s)
    end
  end

  describe 'GET /admin/products/new' do
    it 'display new product form' do
      get new_admin_product_path

      expect(response).to be_successful
      expect(response.body).to include('New Product')
      expect(response.body).to include('Name')
      expect(response.body).to include('Description')
      expect(response.body).to include('Product Category')
      expect(response.body).to include('Status')
      expect(response.body).to include('Create Product')
    end
  end

  describe 'POST /admin/products' do
    context 'when valid params' do
      let(:product_category) { create(:product_category) }

      it 'creates a new product' do
        expect do
          post admin_products_path, params: {
            product: {
              name: 'Printing detail',
              description: 'Detail about printing',
              product_category_id: product_category.id,
              status: 'active'
            }
          }
        end.to change(Product, :count).by(1)
        expect(response).to redirect_to(admin_products_path)
      end
    end

    context 'when invalid params' do
      let(:product_category) { create(:product_category) }

      it 'displays error message' do
        expect do
          post admin_products_path, params: {
            product: {
              name: '',
              description: '',
              product_category_id: '',
              status: ''
            }
          }
        end.not_to change(Product, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('New Product')
        expect(response.body).to include('Name can&#39;t be blank')
        expect(response.body).to include('Description can&#39;t be blank')
        expect(response.body).to include('Product category must exist')
      end
    end
  end
end
