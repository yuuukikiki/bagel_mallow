Rails.application.routes.draw do
  get 'cart_items/create'
  get 'cart_items/update'
  get 'cart_items/destroy'
  get 'carts/show'
  devise_for :users
  root 'items#index'

  # 注文関連のルーティング
  resources :orders, only: [:index, :new, :create]

  # カート関連のルーティング
  resource :cart, only: [:show]  # シングルカートの表示

  # カートアイテムのルーティング
  resources :cart_items, only: [:create, :update, :destroy]
end
