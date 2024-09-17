class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = current_user.cart || Cart.create(user: current_user)

    cart_item = cart.cart_items.find_or_initialize_by(item_id: cart_item_params[:item_id])
    cart_item.quantity += cart_item_params[:quantity].to_i

    if cart_item.save
      redirect_to cart_path(cart), notice: 'カートに商品が追加されました。'
    else
      redirect_to items_path, alert: 'カートに追加できませんでした。'
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: '商品が削除されました。'
  end

  private

  def cart_item_params
    params.permit(:item_id, :quantity)
  end
end
