describe '/dredd/manual_orders', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/manual_orders' do
    let(:manual_order_first) { create(:manual_order) }
    let(:manual_order_second) { create(:manual_order) }

    before do
      manual_order_first
      manual_order_second
    end

    it 'displays all manual orders' do
      get dredd_manual_orders_path

      expect(response).to be_successful
      expect(response.body).to include('PRINT CODE')
      expect(response.body).to include('FULL NAME')
      expect(response.body).to include('MOBILE PHONE')
      expect(response.body).to include('APP CONTACT')
      expect(response.body).to include('PRICE FOR MODELING')
      expect(response.body).to include('PRICE FOR PRINTING')
      expect(response.body).to include('COUNT')
      expect(response.body).to include('TOTAL PRICE')
      expect(response.body).to include('PREPAID EXPENSE')
      expect(response.body).to include('STATUS')
      expect(response.body).to include('DEADLINE')
      expect(response.body).to include('CREATED AT')
      expect(response.body).to include('ACTIONS')
    end
  end
end
