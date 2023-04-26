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
end
