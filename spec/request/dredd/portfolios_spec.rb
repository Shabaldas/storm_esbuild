describe '/dredd/portfolios', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/portfolios' do
    let!(:portfolios) { create_list(:portfolio, 2) }

    it 'display all portfolios' do
      get dredd_portfolios_path

      expect(response).to be_successful
      expect(response.body).to include('ID')
      expect(response.body).to include('NAME')
      expect(response.body).to include('STATUS')
      expect(response.body).to include('CREATED AT')
      expect(response.body).to include('Create New Portfolio')
      expect(response.body).to include('ACTIONS')
      expect(response.body).to include('EDIT')
      expect(response.body).to include('DESTROY')
      expect(response.body).to include(dredd_portfolio_path(portfolios.first))
      expect(response.body).to include(dredd_portfolio_path(portfolios.second))
      expect(response.body).to include(dredd_portfolio_path(portfolios.second))
      expect(response.body).to include(dredd_portfolio_path(portfolios.second))
      expect(response.body).to include(portfolios.first.id.to_s)
      expect(response.body).to include(portfolios.first.name)
      expect(response.body).to include(portfolios.first.portfolio_type)
      expect(response.body).to include(portfolios.first.status)
      expect(response.body).to include(portfolios.second.id.to_s)
      expect(response.body).to include(portfolios.second.name)
      expect(response.body).to include(portfolios.second.portfolio_type)
      expect(response.body).to include(portfolios.second.status)
    end
  end

  describe 'GET /dredd/portfolios/new' do
    it 'display new portfolio form' do
      get new_dredd_portfolio_path

      expect(response).to be_successful
      expect(response.body).to include('New Portfolio')
      expect(response.body).to include('Name')
      expect(response.body).to include('Description')
      expect(response.body).to include('Category name')
      expect(response.body).to include('Status')
      expect(response.body).to include('Portfolio type')
      expect(response.body).to include('Tags')
      expect(response.body).to include('Created by machine')
      expect(response.body).to include('Save')
    end
  end

  describe 'GET /dredd/portfolios/:id/edit' do
    let(:portfolio) { create(:portfolio) }

    it 'display edit portfolio form' do
      get edit_dredd_portfolio_path(portfolio)

      expect(response).to be_successful
      expect(response.body).to include('Edit Portfolio')
    end
  end

  describe 'POST /dredd/portfolios' do
    context 'when valid params' do
      let(:main_picure) { './spec/fixtures/files/dummy.png' }

      it 'creates a new portfolio' do
        expect do
          post dredd_portfolios_path, params: {
            portfolio: {
              name: 'Printing detail',
              description: 'Detail about printing',
              status: 'active',
              portfolio_type: 'rendering',
              tags: 'Tags',
              created_by_machine: 'Solidworks',
              main_picture: fixture_file_upload(main_picure)
            }
          }
        end.to change(Portfolio, :count).by(1)

        expect(response).to redirect_to(dredd_portfolios_path)
        follow_redirect!
        expect(response.body).to include('Portfolio was successfully created.')

        portfolio = Portfolio.last
        expect(portfolio.name).to eq('Printing detail')
        expect(portfolio.description).to eq('Detail about printing')
        expect(portfolio.status).to eq('active')
        expect(portfolio.portfolio_type).to eq('rendering')
        expect(portfolio.tags).to eq('Tags')
        expect(portfolio.created_by_machine).to eq('Solidworks')
      end
    end

    context 'when invalid params' do
      it 'displays error message' do
        expect do
          post dredd_portfolios_path, params: {
            portfolio: {
              name: '',
              description: '',
              status: '',
              main_picture: nil
            }
          }
        end.not_to change(Portfolio, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('New Portfolio')
        expect(response.body).to include(html_escape("Name can't be blank"))
        expect(response.body).to include(html_escape("Main picture can't be blank"))
      end
    end
  end

  describe 'PUT /dredd/portfolios/:id' do
    let(:portfolio) { create(:portfolio) }

    context 'when valid params' do
      it 'updates a portfolio' do
        put dredd_portfolio_path(portfolio), params: {
          portfolio: {
            name: 'Printing detail',
            description: 'Detail about printing',
            status: 'active',
            portfolio_type: 'rendering',
            tags: 'Tags',
            created_by_machine: 'Solidworks'
          }
        }

        expect(response).to redirect_to(dredd_portfolios_path)
        follow_redirect!
        expect(response.body).to include('Portfolio was successfully updated.')

        portfolio.reload
        expect(portfolio.name).to eq('Printing detail')
        expect(portfolio.description).to eq('Detail about printing')
        expect(portfolio.status).to eq('active')
        expect(portfolio.portfolio_type).to eq('rendering')
        expect(portfolio.tags).to eq('Tags')
        expect(portfolio.created_by_machine).to eq('Solidworks')
      end
    end

    context 'when invalid params' do
      it 'displays error message' do
        put dredd_portfolio_path(portfolio), params: {
          portfolio: {
            name: '',
            description: '',
            status: '',
            main_picture: nil
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Edit Portfolio')
        expect(response.body).to include(html_escape("Name can't be blank"))
        expect(response.body).to include(html_escape("Main picture can't be blank"))
      end
    end
  end

  describe 'DELETE /dredd/portfolios/:id' do
    let!(:portfolio) { create(:portfolio) }

    it 'deletes a portfolio' do
      expect do
        delete dredd_portfolio_path(portfolio)
      end.to change(Portfolio, :count).by(-1)
      expect(response).to redirect_to(dredd_portfolios_path)
      follow_redirect!
      expect(response.body).to include('Portfolio was successfully destroyed.')
    end
  end
end
