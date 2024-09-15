class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart

    if @cart.present?
      @cart_items = @cart.cart_items.includes(:item)
      @cart_item = CartItem.new
      @items = Item.all
    else
      # カートが存在しない場合の処理
      flash[:alert] = 'カートが存在しません。'
      redirect_to root_path # 例としてトップページにリダイレクト
    end
  end

  def count
    render json: { count: current_cart.items.count }
  end
end
