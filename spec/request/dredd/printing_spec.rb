describe '/dredd/printing_orders', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/printing_orders' do
    it 'displays all printing orders' do
      get dredd_printing_orders_path

      expect(response).to be_successful
      expect(response.body).to include('ID')
      expect(response.body).to include('Full name')
      expect(response.body).to include('Phone number')
      expect(response.body).to include('Email')
      expect(response.body).to include('Status')
      expect(response.body).to include('Price')
      expect(response.body).to include('Deadline')
      expect(response.body).to include('Comment')
      expect(response.body).to include('Actions')
    end
  end

  describe 'DELETE /dredd/printing_orders/:id' do
    let!(:printing_order) { create(:printing_order) }

    it 'deletes printing order' do
      expect { delete dredd_printing_order_path(printing_order) }.to change(PrintingOrder, :count).by(-1)
    end
  end
end
