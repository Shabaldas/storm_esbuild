Rails.application.routes.draw do
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
  root 'static_pages#home', as: :home

  resources :products, only: [:index, :show]

  mount ApiV1 => '/'
end
