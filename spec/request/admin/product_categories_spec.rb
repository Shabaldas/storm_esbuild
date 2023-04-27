describe '/admin/product_categories', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /admin/product_categories' do
    let!(:product_categories) { create_list(:product_category, 2) }

    it 'display all product_categories' do
      get admin_product_categories_path

      expect(response).to be_successful
      expect(response.body).to include('ID')
      expect(response.body).to include('NAME')
      expect(response.body).to include('DESCRIPTION')
      expect(response.body).to include('CREATED AT')
      expect(response.body).to include(product_categories.first.id.to_s)
      expect(response.body).to include(product_categories.first.name)
      expect(response.body).to include(product_categories.first.description)
      expect(response.body).to include(product_categories.first.name)
      expect(response.body).to include(product_categories.second.id.to_s)
      expect(response.body).to include(product_categories.second.name)
      expect(response.body).to include(product_categories.second.description)
    end
  end
end
