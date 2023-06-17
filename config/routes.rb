Rails.application.routes.draw do
  root 'static_pages#home'

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :products, except: [:update]
    resources :product_categories, except: [:update]
    resources :feedback_calls, only: [:index]
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }

  post 'save_phone_number', to: 'static_pages#save_phone_number'
  patch 'cart/update_quantity'

  namespace :carts do
    resources :cart_items, only: [:create, :destroy] do
      patch :update_quantity, on: :member
    end

    resource :add, only: [:create]
    resource :reduce, only: [:create]
    resource :remove, only: [:destroy]
  end

  resources :products, only: [:index, :show]
  resources :calculators, only: :index

  mount ApiV1 => '/'
end
