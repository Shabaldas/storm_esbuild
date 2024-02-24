# rubocop:disable Metrics/BlockLength
require 'sidekiq/web'

Rails.application.routes.draw do
  root 'static_pages#home'
  namespace :dredd do
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == SidekiqConfig.new.username && password == SidekiqConfig.new.password
    end

    mount Sidekiq::Web => '/sidekiq'

    get '/', to: 'dashboard#index', as: :dashboard
    resources :products, except: [:update]
    resources :product_categories, except: [:update]
    resources :feedback_calls, only: [:index, :update, :destroy]
    resources :orders, only: [:index, :show]
    resources :manual_orders, except: :show
    resources :modeling_orders, except: [:new, :show]
    resources :rendering_orders, except: [:new, :show]
    resources :printing_orders, except: [:new, :show]
    resources :users, except: [:destroy]
    resources :printers, except: :show
    resources :portfolios, except: :show
    resources :costs, only: [:create, :destroy]
    resources :workers, except: [:show]
    resources :accountings, only: :index do
      get :monthly, on: :collection
    end
    resources :clients, except: [:destroy]
  end

  put 'locales/:locale', to: 'locales#update', as: :locale,
                         constraints: { locale: /#{I18n.available_locales.join('|')}/ }

  get '/users/edit', to: redirect('404')

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :profiles, only: :show
  get 'edit_personal_data/:id', to: 'profiles#edit_personal_data', as: 'edit_personal_data'
  get 'edit_password/:id', to: 'profiles#edit_password', as: 'edit_password'
  put 'update_personal_data/:id', to: 'profiles#update_personal_data', as: 'update_personal_data'
  patch 'update_password/:id', to: 'profiles#update_password', as: 'update_password'

  get 'static_pages/home_lazy', to: 'static_pages#home_lazy'
  get '/sitemap.xml', to: 'static_pages#sitemap'
  get 'printing', to: 'printing_orders#index'
  get '3d_printing_city/:city', to: 'printing_orders#printing_in_your_city', as: 'printing_city'
  get 'rendering', to: 'rendering_orders#index'
  get '3d_rendering/:city', to: 'rendering_orders#rendering_in_your_city', as: 'rendering_city'
  get 'rendering/lazy', to: 'rendering_orders#lazy'
  get 'modeling', to: 'modeling_orders#index'
  get 'modeling/lazy_index', to: 'modeling_orders#lazy_index'
  get '3d_modeling/:city', to: 'modeling_orders#modeling_in_your_city', as: 'modeling_city'
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
