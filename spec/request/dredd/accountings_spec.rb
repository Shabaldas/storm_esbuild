describe '/dredd/accountings', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/accountings/index' do
    it 'display general accounting page' do
      get dredd_accountings_path

      expect(response).to be_successful
      expect(response.body).to include('Accountings this month')
      expect(response.body).to include('Accountings for previous months')
      expect(response.body).to include('Earning')
      expect(response.body).to include('Costs')
    end

    context 'when orders data present' do
      let(:freezed_time) { Time.utc(2023, 10, 10, 10, 0, 0) }

      before do
        Timecop.freeze(freezed_time)
        create_list(:manual_order, 2, status: :paid, total_price: 1000, end_date: freezed_time)
        create_list(:manual_order, 2, status: :paid, total_price: 1500, end_date: 1.month.ago)
        create_list(:manual_order, 4, status: :paid, total_price: 2000, end_date: 2.months.ago)
        create_list(:manual_order, 2, status: :paid, total_price: 3000, end_date: 3.months.ago)
        create_list(:manual_order, 2, status: :paid, total_price: 5000, end_date: 5.months.ago)
      end

      it 'diplay earning information' do
        get dredd_accountings_path
        # manual_order price for current month
        expect(response.body).to include('UAH 2000.0')

        # order months for last six months
        expect(response.body).to include('Aug 2023')
        expect(response.body).to include('Jul 2023')
        expect(response.body).to include('Jun 2023')
        expect(response.body).to include('May 2023')
        expect(response.body).to include('Apr 2023')
        expect(response.body).not_to include('Mar 2023')

        # order total_price sum for previouns months
        expect(response.body).to include('UAH 3000.0')
        expect(response.body).to include('UAH 8000.0')
        expect(response.body).to include('UAH 6000.0')
        expect(response.body).to include('UAH 0')
        expect(response.body).to include('UAH 10000')
        expect(response.body).to include(monthly_dredd_accountings_path)
      end
    end

    context 'when earning data is empty' do
      it 'diplay message for empty earning data' do
        get dredd_accountings_path

        expect(response.body).to include('-')
        expect(response.body).to include('UAH 0')
      end
    end
  end

  describe 'GET /dredd/accountings/monthly' do
    context 'when data present' do
      let(:freezed_time) { Time.utc(2023, 10, 1, 10, 0, 0) }

      before do
        Timecop.freeze(freezed_time)
        create_list(:manual_order, 2, status: :paid, total_price: 1000, end_date: freezed_time)
        create_list(:manual_order, 2, status: :paid, total_price: 1500, end_date: 1.month.ago)
      end

      after { Timecop.return }

      it 'display earning information for current month' do
        get monthly_dredd_accountings_path(params: { date: [1.month.ago.month, 1.month.ago.year].join('/') })

        expect(response).to be_successful
        expect(response.body).to include('Back')
        expect(response.body).to include('Order')
        expect(response.body).to include('Costs')
        expect(response.body).to include('Costs are empty')
        expect(response.body).to include('UAH 3000.0')
      end
    end

    context 'when data empty' do
      it 'display message for empty information and general information' do
        get monthly_dredd_accountings_path(params: { date: [1.month.ago.month, 1.month.ago.year].join('/') })

        expect(response).to be_successful
        expect(response.body).to include('Orders are empty')
        expect(response.body).to include('Costs are empty')
      end
    end
  end
end
