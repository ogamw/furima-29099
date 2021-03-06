Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  get 'items/search'
  root to: "items#index"
  resources :items do
    resources :orders, only:[:index, :new, :create]
  end
  resources :users, only: :show
end
