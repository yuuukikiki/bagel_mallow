Rails.application.routes.draw do
  get 'orders/index'
  devise_for :users
  root 'items#index'
end
