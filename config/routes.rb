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
  post 'cart/add'

  resources :products, only: [:index, :show]

  mount ApiV1 => '/'
end
