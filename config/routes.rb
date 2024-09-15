Rails.application.routes.draw do
  get 'profiles/show'
  get 'profiles/order_history'
    # お問い合わせページのルーティング
    resources :contacts, only: [:new, :create]

    # カート関連のルーティング
    resource :cart, only: [:show]

    # カートアイテムのルーティング
    resources :cart_items, only: [:create, :update, :destroy]

    # 注文関連のルーティング
    resources :orders, only: [:index, :new, :create] do
      collection do
        get 'complete'
      end
    end

    # ユーザー認証関連のルーティング
    devise_for :users

    # トップページのルーティング
    root 'items#index'

    # マイページのルーティング
    resource :profile, only: [:show] do
      get 'order_history', on: :collection
    end
end
