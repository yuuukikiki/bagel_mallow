Rails.application.routes.draw do
  # ==============================
  # ユーザー用ルーティング
  # ==============================

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
  resources :orders, only: [:index, :new, :create] do
    member do
      get 'complete'
    end
  end

  # マイページ
  resource :profile, only: [:show] do
    get 'order_history', on: :collection
  end

  # ==============================
  # 管理者用ルーティング
  # ==============================

  # 管理者認証
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    # 管理者ダッシュボード
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
  end
end