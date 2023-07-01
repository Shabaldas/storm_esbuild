describe '/admin/orders', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /admin/orders' do
    # TODO: see comments below
    let(:order_first) { create(:order, :unpaid) } # user should be registrated
    let(:order_second) { create(:order, :unpaid) } # user should't be registrated
    let(:order_third) { create(:order, :paid) } # user should be registrated

    before do
      order_first
      order_second
      order_third
    end

    it 'display all orders' do
      get admin_orders_path

      expect(response).to be_successful
      expect(response.body).to include('ID')
      expect(response.body).to include('FULL NAME')
      expect(response.body).to include('PHONE')
      expect(response.body).to include('EMAIL')
      expect(response.body).to include('SUBTOTAL')
      expect(response.body).to include('TOTAL')
      expect(response.body).to include('COMMENT')
      expect(response.body).to include('CREATED AT')
      expect(response.body).to include('UPDATED AT')
      expect(response.body).to include('ACTIONS')
      expect(response.body).to include(order_first.id.to_s)
      expect(response.body).to include(html_escape(order_first.user_full_name))
      expect(response.body).to include(order_first.phone)
      expect(response.body).to include(order_first.email)
      expect(response.body).to include(order_first.subtotal.to_s)
      expect(response.body).to include(order_first.total.to_s)
      expect(response.body).to include(order_first.comment.to_s)
      expect(response.body).to include(order_first.created_at.strftime('%F').to_s)
      expect(response.body).to include(order_first.updated_at.strftime('%F').to_s)
      expect(response.body).to include(order_second.id.to_s)
      expect(response.body).to include(html_escape(order_second.user_full_name))
      expect(response.body).to include(order_second.phone)
      expect(response.body).to include(order_second.email)
      expect(response.body).to include(order_second.subtotal.to_s)
      expect(response.body).to include(order_second.total.to_s)
      expect(response.body).to include(order_second.comment.to_s)
      expect(response.body).to include(order_second.created_at.strftime('%F').to_s)
      expect(response.body).to include(order_second.updated_at.strftime('%F').to_s)
      expect(response.body).to include(order_third.id.to_s)
      expect(response.body).to include(html_escape(order_third.user_full_name))
      expect(response.body).to include(order_third.phone)
      expect(response.body).to include(order_third.email)
      expect(response.body).to include(order_third.subtotal.to_s)
      expect(response.body).to include(order_third.total.to_s)
      expect(response.body).to include(order_third.comment.to_s)
      expect(response.body).to include(order_third.created_at.strftime('%F').to_s)
      expect(response.body).to include(order_third.updated_at.strftime('%F').to_s)
      expect(response.body).to include(admin_order_path(order_first))
      expect(response.body).to include(admin_order_path(order_second))
      expect(response.body).to include(admin_order_path(order_third))
    end
  end
end
