class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart
    @item = Item.find(params[:item_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(item: @item)
    @cart_item.quantity += params[:quantity].to_i
    @cart_item.save
    redirect_to cart_path
  end

  def update
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_path
  end

  def destroy
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
