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
      let(:product_category) { create(:product_category, name: 'Home') }

      context 'when simple product' do
        it 'creates a new product' do
          expect do
            post admin_products_path, params: {
              product: {
                name: 'Printing detail',
                description: 'Detail about printing',
                product_category_id: product_category.id,
                status: 'active',
                price: 10.0
              }
            }
          end.to change(Product, :count).by(1)
          expect(response).to redirect_to(admin_products_path)
        end
      end

      context 'when primary option (color)' do
        let(:color_option) { create(:option, measurement: 'color') }
        let(:option_value_first) { create(:option_value, option: color_option) }
        let(:option_value_second) { create(:option_value, option: color_option) }

        context 'when primary option checked' do
          let(:primary_product_option_params) do
            {
              'primary_product_option_attributes' => {
                'primary' => true,
                'option_id' => color_option.id
              }
            }
          end

          it 'creates a new product with color option and product option values' do
            expect do
              post admin_products_path, params: {
                product: {
                  name: 'Printing detail',
                  description: 'Detail about printing',
                  product_category_id: product_category.id,
                  status: 'inactive',
                  price: 10.0,
                  primary_product_option_attributes: {
                    primary: true,
                    option_id: color_option.id,
                    product_option_values_attributes: [
                      { option_value_id: option_value_first.id, price: 0.0 },
                      { option_value_id: option_value_second.id, price: 0.0 }
                    ]
                  }
                }
              }
            end.to change(Product, :count).by(1)

            product = Product.last

            expect(product.product_category.name).to eq('Home')
            expect(product.name).to eq('Printing detail')
            expect(product.description).to eq('Detail about printing')
            expect(product.status).to eq('inactive')
            expect(product.price).to eq(10.0)
            expect(product.product_options.count).to eq(1)
            expect(product.product_options.first.option.measurement).to eq('color')
            expect(product.primary_product_option.option).to eq(color_option)
            expect(product.product_option_values.count).to eq(2)
          end
        end
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
