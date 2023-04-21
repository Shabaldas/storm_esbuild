Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'static_pages#home'

  resources :products, only: [:index, :show]

  mount ApiV1 => '/'
end
