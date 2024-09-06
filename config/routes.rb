Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  # 注文関連のルーティング
  resources :orders, only: [:index, :new, :create]
end
