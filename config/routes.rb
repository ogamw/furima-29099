Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root to: "items#index"
  resources :items
  resources :users, only: :show
  get 'orders/index'
  resources :orders, only:[:create]
end
