Rails.application.routes.draw do
  root 'static_pages#home'

  namespace :admin do
    resources :product_categories
    resources :products
    resources :options
    resources :option_values
    resources :option_values
    resources :product_options
    resources :product_option_values
    resources :users

    root to: 'product_categories#index'
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :products, only: [:index, :show]

  mount ApiV1 => '/'
end
