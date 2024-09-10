class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart

    if @cart.present?
      @cart_items = @cart.cart_items.includes(:item)
    else
      # カートが存在しない場合の処理
      flash[:alert] = 'カートが存在しません。'
      redirect_to root_path # 例としてトップページにリダイレクト
    end
  end
end
