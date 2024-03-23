describe '/dredd/products', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/products' do
    let(:product_category) { create(:product_category, :with_parent) }
    let!(:products) { create_list(:product, 2, product_category:) }

    it 'display all products' do
      get dredd_products_path

      expect(response).to be_successful
      expect(response.body).to include('ID')
      expect(response.body).to include('NAME')
      expect(response.body).to include('PRODUCT CATEGORY')
      expect(response.body).to include('STATUS')
      expect(response.body).to include('CREATED AT')
      expect(response.body).to include('Create New Product')
      expect(response.body).to include('ACTIONS')
      expect(response.body).to include('EDIT')
      expect(response.body).to include('DESTROY')
      expect(response.body).to include(dredd_product_path(products.first))
      expect(response.body).to include(dredd_product_path(products.second))
      expect(response.body).to include(edit_dredd_product_path(products.second))
      expect(response.body).to include(edit_dredd_product_path(products.second))
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

  describe 'GET /dredd/products/:id' do
    let(:product_category) { create(:product_category, :with_parent) }
    let(:product) { create(:product, product_category:) }

    it 'display product' do
      get dredd_product_path(product)

      expect(response).to be_successful
      expect(response.body).to include(product.name)
      expect(response.body).to include(product.product_category.name)
      expect(response.body).to include(product.price.to_i.to_s)
    end
  end

  describe 'GET /dredd/products/new' do
    let(:option) { create(:option, measurement: 'color') }

    before do
      option
    end

    it 'display new product form' do
      get new_dredd_product_path

      expect(response).to be_successful
      expect(response.body).to include('New Product')
      expect(response.body).to include('Name')
      expect(response.body).to include('Description')
      expect(response.body).to include('Product Category')
      expect(response.body).to include('Status')
      expect(response.body).to include('Create Product')
    end
  end

  describe 'GET /dredd/products/:id/edit' do
    let(:product_category) { create(:product_category, :with_parent) }
    let(:product) { create(:product, product_category:) }

    it 'display edit product form' do
      get edit_dredd_product_path(product)

      expect(response).to be_successful
      expect(response.body).to include('Edit Product')
    end
  end

  describe 'POST /dredd/products' do
    context 'when valid params' do
      let(:product_category) { create(:product_category, :with_parent, name: 'Home') }
      let(:main_picure) { './spec/fixtures/files/dummy.png' }

      context 'when simple product' do
        it 'creates a new product' do
          expect do
            post dredd_products_path, params: {
              product: {
                name: 'Printing detail',
                description: 'Detail about printing',
                product_category_id: product_category.id,
                status: 'active',
                main_picture: fixture_file_upload(main_picure)
              }
            }
          end.to change(Product, :count).by(1)

          expect(response).to redirect_to(dredd_products_path)
          follow_redirect!
          expect(response.body).to include('Product was successfully created.')
        end
      end

      context 'when primary option selected' do
        let(:color_option) { create(:option, measurement: 'color') }
        let(:option_value_first) { create(:option_value, option: color_option) }
        let(:option_value_second) { create(:option_value, option: color_option) }
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
            post dredd_products_path, params: {
              product: {
                name: 'Printing detail',
                description: 'Detail about printing',
                product_category_id: product_category.id,
                status: 'inactive',
                main_picture: fixture_file_upload(main_picure),
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

      context 'when secondary option selected' do
        let(:size_option) { create(:option, measurement: 'mm') }
        let(:option_value_first) { create(:option_value, option: size_option) }
        let(:option_value_second) { create(:option_value, option: size_option) }
        let(:secondary_product_option_params) do
          {
            'secondary_product_option_attributes' => {
              'primary' => false,
              'option_id' => size_option.id
            }
          }
        end

        it 'create a new product with size option product option values' do
          expect do
            post dredd_products_path, params: {
              product: {
                name: 'Printing detail',
                description: 'Detail about printing',
                product_category_id: product_category.id,
                status: 'inactive',
                main_picture: fixture_file_upload(main_picure),
                price: 10.0,
                secondary_product_option_attributes: {
                  primary: false,
                  option_id: size_option.id,
                  product_option_values_attributes: [
                    { option_value_id: option_value_first.id, price: 20.0 },
                    { option_value_id: option_value_second.id, price: 30.0 }
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
          expect(product.product_options.first.option.measurement).to eq('mm')
          expect(product.secondary_product_option.option).to eq(size_option)
          expect(product.product_option_values.count).to eq(2)
        end
      end
    end

    context 'when invalid params' do
      let(:product_category) { create(:product_category) }
      let(:option) { create(:option, measurement: 'color') }

      before do
        option
      end

      it 'displays error message' do
        expect do
          post dredd_products_path, params: {
            product: {
              name: '',
              description: '',
              product_category: product_category.id,
              status: '',
              main_picture: nil,
              price: nil,
              primary_product_option_attributes: {
                primary: true,
                option_id: '',
                product_option_values_attributes: [
                  { option_value_id: '', price: nil },
                  { option_value_id: '', price: nil }
                ]
              },
              secondary_product_option_attributes: {}
            }
          }
        end.not_to change(Product, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('New Product')
        expect(response.body).to include(html_escape("Can't be blank"))
      end
    end
  end

  describe 'DELETE /dredd/products/:id' do
    let!(:product_category) { create(:product_category, :with_parent) }
    let!(:product) { create(:product, product_category:) }

    it 'deletes a product' do
      expect do
        delete dredd_product_path(product)
      end.to change(Product, :count).by(-1)
      expect(response).to redirect_to(dredd_products_path)
      follow_redirect!
      expect(response.body).to include('Product was successfully destroyed.')
    end
  end
end
