Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
    get 'search', to: 'students#search'
  resources :items , only:[:new, :create, :show, :destroy, :edit, :update] do
    resources :orders, only:[:index, :new, :create]
  end
  resources :users, only: :show
end
