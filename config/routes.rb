Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root to: "items#index"
  resources :items do
    resources :orders, only:[:index, :new, :create]
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
end
