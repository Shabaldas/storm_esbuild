Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home', as: :home

  resources :products, only: :index
end
