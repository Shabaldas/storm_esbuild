Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'static_pages#home', as: :home

  resources :products, only: [:index, :show]

  mount ApiV1 => '/'
end
