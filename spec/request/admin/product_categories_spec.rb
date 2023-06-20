describe '/admin/product_categories', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /admin/product_categories/new' do
    it 'display new product_category form' do
      get new_admin_product_category_path

      expect(response).to be_successful
      expect(response.body).to include('New Product Category')
      expect(response.body).to include('Name')
      expect(response.body).to include('Description')
      expect(response.body).to include('Parent')
      expect(response.body).to include('Create Product Category')
    end
  end

  describe 'GET /admin/product_categories' do
    let!(:product_category_first) { create(:product_category, name: 'Home') }
    let!(:product_category_second) { create(:product_category, name: 'Design') }

    it 'display all product_categories' do
      get admin_product_categories_path

      expect(response).to be_successful
      expect(response.body).to include('ID')
      expect(response.body).to include('NAME')
      expect(response.body).to include('DESCRIPTION')
      expect(response.body).to include('CREATED AT')
      expect(response.body).to include('Create New Product Category')
      expect(response.body).to include('ACTIONS')
      expect(response.body).to include('EDIT')
      expect(response.body).to include('DESTROY')
      expect(response.body).to include(admin_product_category_path(product_category_first))
      expect(response.body).to include(admin_product_category_path(product_category_second))
      expect(response.body).to include(edit_admin_product_category_path(product_category_first))
      expect(response.body).to include(edit_admin_product_category_path(product_category_second))
      expect(response.body).to include(product_category_first.id.to_s)
      expect(response.body).to include(product_category_first.name)
      expect(response.body).to include(product_category_first.description)
      expect(response.body).to include(product_category_second.id.to_s)
      expect(response.body).to include(product_category_second.name)
      expect(response.body).to include(product_category_second.description)
    end
  end

  describe 'GET /admin/product_category/:id' do
    context 'when the product category has children' do
      let(:product_category) { create(:product_category, :with_children, name: 'Print') }

      it 'display the product category' do
        get admin_product_category_path(product_category)

        expect(response).to be_successful
        expect(response.body).to include(product_category.name)
        expect(response.body).to include(product_category.description)
        expect(response.body).to include(product_category.children.first.name)
        expect(response.body).to include(product_category.children.last.name)
      end
    end

    context 'when product category has parent' do
      let(:product_category) { create(:product_category, :with_parent, name: 'Children category') }

      it 'display the product category' do
        get admin_product_category_path(product_category)

        expect(response).to be_successful
        expect(response.body).to include(product_category.name)
        expect(response.body).to include(product_category.description)
        expect(response.body).to include(product_category.parent.name)
      end
    end
  end

  describe 'GET /admin/product_categories/edit' do
    let(:product_category) { create(:product_category, name: 'Home') }

    it 'display the product category' do
      get edit_admin_product_category_path(product_category)

      expect(response).to be_successful
      expect(response.body).to include('Edit Product Category')
    end
  end

  describe 'POST /admin/product_categories' do
    context 'when valid params and parent empty' do
      it 'creates a new product_category' do
        expect do
          post admin_product_categories_path, params: {
            product_category: {
              name: 'World',
              description: 'Product Category description'
            }
          }
        end.to change(ProductCategory, :count).by(1)
        expect(response).to redirect_to(admin_product_categories_path)
        follow_redirect!
        expect(response.body).to include('Product category was successfully created.')
      end
    end

    context 'when valid params and parent present' do
      let!(:product_category) { create(:product_category, name: 'Home') }

      it 'creates a new product_category' do
        expect do
          post admin_product_categories_path, params: {
            product_category: {
              name: 'World',
              description: 'Product Category description',
              ancestry: product_category.id
            }
          }
        end.to change(ProductCategory, :count).by(1)
        created_product_category = ProductCategory.last
        expect(created_product_category.has_parent?).to be(true)
        expect(created_product_category.parent).to eq(product_category)
        expect(response).to redirect_to(admin_product_categories_path)
        follow_redirect!
        expect(response.body).to include('Product category was successfully created.')
      end
    end

    context 'when valid params and parent has neseted children' do
      let!(:product_category_parent) { create(:product_category, name: 'Home') }
      let!(:product_category_child) { create(:product_category, ancestry: product_category_parent.id, name: 'Desigin') }

      it 'creates a new product_category' do
        expect do
          post admin_product_categories_path, params: {
            product_category: {
              name: 'World',
              description: 'Product Category description',
              ancestry: product_category_child.id
            }
          }
        end.to change(ProductCategory, :count).by(1)
        created_product_category = ProductCategory.last
        expect(created_product_category.has_parent?).to be(true)
        expect(created_product_category.parent).to eq(product_category_child)
        expect(product_category_parent.descendants.count).to eq(2)
        expect(product_category_parent.children.count).to eq(1)
        expect(product_category_child.children.count).to eq(1)
        expect(response).to redirect_to(admin_product_categories_path)
        follow_redirect!
        expect(response.body).to include('Product category was successfully created.')
      end
    end

    context 'when invalid params' do
      it 'display error message' do
        expect do
          post admin_product_categories_path, params: {
            product_category: {
              name: '',
              description: ''
            }
          }
        end.not_to change(ProductCategory, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('New Product Category')
        expect(response.body).to include(html_escape("Name can't be blank"))
        expect(response.body).to include(html_escape("Description can't be blank"))
      end
    end
  end

  describe 'DELETE /admin/product_categories/:id' do
    let!(:product_category) { create(:product_category, name: 'Home') }

    it 'destroy the product category' do
      expect do
        delete admin_product_category_path(product_category)
      end.to change(ProductCategory, :count).by(-1)
      expect(response).to redirect_to(admin_product_categories_path)
      follow_redirect!
      expect(response.body).to include('Product category was successfully destroyed.')
    end
  end
end
