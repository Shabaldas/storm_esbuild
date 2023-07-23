# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  root 'static_pages#home'
  namespace :dredd do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :products, except: [:update]
    resources :product_categories, except: [:update]
    resources :feedback_calls, only: [:index]
    resources :orders, only: [:index, :show]
    resources :manual_orders, except: :show
    resources :users, except: [:show, :destroy]
  end

  put 'locales/:locale', to: 'locales#update', as: :locale,
                         constraints: { locale: /#{I18n.available_locales.join('|')}/ }

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  post 'save_phone_number', to: 'static_pages#save_phone_number'
  get 'printing', to: 'static_pages#printing'
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
  resource :print, only: [:show]
  resources :print_models, only: [] do
    post :manage, on: :collection
  end

  mount ApiV1 => '/'
end
# rubocop:enable Metrics/BlockLength
