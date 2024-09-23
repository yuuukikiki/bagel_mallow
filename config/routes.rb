Rails.application.routes.draw do
  # ユーザー認証
  devise_for :users

  # トップページ
  root 'items#index'

  # カート関連
  resource :cart, only: [:show] do
    get 'count', on: :collection
  end

  # カートアイテム
  resources :cart_items, only: [:create, :update, :destroy]

  # 注文関連 (ユーザー向け)
  resources :orders do
    member do
      get 'complete'
    end
  end

  # マイページ
  resource :profile, only: [:show] do
    get 'order_history', on: :collection
  end
end