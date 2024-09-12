class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart || Cart.create(user: current_user)

    cart_items_params.each do |item_id, quantity|
      item = Item.find(item_id)
      quantity = quantity.to_i

      next unless quantity > 0

      @cart_item = @cart.cart_items.find_by(item_id: item.id)

      if @cart_item
        @cart_item.quantity += quantity
      else
        @cart_item = @cart.cart_items.new(item:, quantity:)
      end

      @cart_item.save
    end

    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: 'カートに商品が追加されました。' }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart_icon', partial: 'carts/cart_icon',
                                                               locals: { cart_items_count: @cart.cart_items.count })
      end
    end
  end

  private

  def cart_items_params
    params.require(:cart_items).permit!
  end
end
