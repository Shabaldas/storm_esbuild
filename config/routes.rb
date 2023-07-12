# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  root 'static_pages#home'

  namespace :dredd do
    get '/', to: 'dashboard#index', as: :dashboard
    get 'all_orders', to: 'dashboard#all_orders'
    resources :products, except: [:update]
    resources :product_categories, except: [:update]
    resources :feedback_calls, only: [:index]
    resources :orders, only: [:index, :show]
    resources :manual_orders
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }

  post 'save_phone_number', to: 'static_pages#save_phone_number'
  patch 'cart/update_quantity'
  get :calculator, to: 'print_models#new', as: :calculator
  get 'checkout', to: 'orders#checkout', as: :checkout

  namespace :carts do
    resources :cart_items, only: [:create, :destroy] do
      patch :update_quantity, on: :member
    end
    resource :remove, only: [:destroy]
  end

  resources :products, only: [:index, :show]
  resources :print_models, only: [] do
    post :manage, on: :collection
  end

  mount ApiV1 => '/'
end
# rubocop:enable Metrics/BlockLength
