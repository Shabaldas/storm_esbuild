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
end
