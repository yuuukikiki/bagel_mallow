Rails.application.routes.draw do
   # ユーザー認証
   devise_for :users

   # 管理者認証
  devise_for :admins, class_name: 'Admin'

  # トップページ
  root 'items#index'

  # 管理者用ルーティング
  namespace :admin do
    root to: 'dashboard#index'

    # 商品管理
    resources :items

    # 注文管理
    resources :orders

    # お問い合わせ管理
    resources :contacts

    # ユーザー管理（必要な場合）
    resources :users

     # サイト設定管理
    resource :settings, only: [:edit, :update]
  end

  # お問い合わせページ
  resources :contacts, only: [:new, :create]

  # カート関連
  resource :cart, only: [:show] do
    get 'count', on: :collection
  end

  # カートアイテム
  resources :cart_items, only: [:create, :update, :destroy]

  # 注文関連
  resources :orders, only: [:index, :new, :create] do
    collection do
      get 'complete'
    end
  end

  # マイページ
  resource :profile, only: [:show] do
    get 'order_history', on: :collection
  end
end