# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  root 'static_pages#home'
  namespace :dredd do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :products, except: [:update]
    resources :product_categories, except: [:update]
    resources :feedback_calls, only: [:index, :update, :destroy]
    resources :orders, only: [:index, :show]
    resources :manual_orders, except: :show
    resources :modeling_orders, except: [:new, :show]
    resources :rendering_orders, except: [:new, :show]
    resources :printing_orders, except: [:new, :show]
    resources :users, except: [:show, :destroy]
    resources :printers, except: :show
  end

  put 'locales/:locale', to: 'locales#update', as: :locale,
                         constraints: { locale: /#{I18n.available_locales.join('|')}/ }

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get 'printing', to: 'printing_orders#index'
  get 'rendering', to: 'rendering_orders#index'
  get 'modeling', to: 'modeling_orders#index'
  get 'calculator', to: 'print_models#new', as: :calculator
  get 'checkout', to: 'orders#checkout', as: :checkout

  patch 'cart/update_quantity'
  post 'save_phone_number', to: 'static_pages#save_phone_number'

  namespace :carts do
    resources :cart_items, only: [:create, :destroy] do
      patch :update_quantity, on: :member
    end
    resource :remove, only: [:destroy]
  end

  resources :modeling_orders, only: :create
  resources :rendering_orders, only: :create
  resources :printing_orders, only: :create
  resources :products, only: [:index, :show]
  resources :print_models, only: [] do
    post :manage, on: :collection
  end

  mount ApiV1 => '/'
end
# rubocop:enable Metrics/BlockLength
