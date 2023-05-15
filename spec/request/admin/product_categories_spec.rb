describe '/admin/product_categories', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
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
      end
    end

    context 'when valid params and children present' do
      let!(:product_category_one) { create(:product_category, name: 'Home') }
      let!(:product_category_two) { create(:product_category, name: 'Design') }

      it 'creates a new product_category' do
        expect do
          post admin_product_categories_path, params: {
            product_category: {
              name: 'World',
              description: 'Product Category description',
              children: [product_category_one.id, product_category_two.id]
            }
          }
        end.to change(ProductCategory, :count).by(1)

        created_product_category = ProductCategory.last
        expect(created_product_category.children.ids).to eq([product_category_one.id, product_category_two.id])
        expect(created_product_category.has_children?).to be(true)
        expect(product_category_one.reload.has_parent?).to be(true)
        expect(product_category_two.reload.has_parent?).to be(true)
        expect(response).to redirect_to(admin_product_categories_path)
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
end
