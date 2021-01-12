Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items, only:[:new, :create, :destroy, :update, :show]
    get 'search', to: 'students#search'
  resources :items do
    resources :orders, only:[:index, :new, :create]
  end
  resources :users, only: :show
end
