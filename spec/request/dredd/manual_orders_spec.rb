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
      expect(response.body).to include(new_dredd_manual_order_path)
      expect(response.body).to include('Create Manual Order')
    end
  end

  describe 'GET /dredd/manual_orders/new' do
    it 'display new manual order form' do
      get new_dredd_manual_order_path

      expect(response).to be_successful
      expect(response.body).to include('New Manual Order')
      expect(response.body).to include('First name')
      expect(response.body).to include('Last name')
      expect(response.body).to include('Phone number')
      expect(response.body).to include('App contact')
      expect(response.body).to include('Email')
      expect(response.body).to include('Price for modeling')
      expect(response.body).to include('Price for printing')
      expect(response.body).to include('Count')
      expect(response.body).to include('Total price')
      expect(response.body).to include('Status')
      expect(response.body).to include('Prepaid expense')
      expect(response.body).to include('Print material')
      expect(response.body).to include('Print color')
      expect(response.body).to include('Printed on printers')
      expect(response.body).to include('Deadline')
      expect(response.body).to include('Comment')
      expect(response.body).to include('Create Manual Order"')
    end
  end

  describe 'DELETE /dredd/manual_orders/:id' do
    let(:manual_order_first) { create(:manual_order) }
    let(:manual_order_second) { create(:manual_order) }

    before do
      manual_order_first
      manual_order_second
    end

    it 'deletes the manual order' do
      expect do
        delete dredd_manual_order_path(manual_order_first)
      end.to change(ManualOrder, :count).by(-1)
      expect(response).to redirect_to(dredd_manual_orders_path)
      follow_redirect!
      expect(response.body).to include('Manual Order was successfully destroyed.')
    end
  end
end
