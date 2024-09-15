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


  def create
    cart = current_user.cart || Cart.create(user: current_user)

    cart_item = cart.cart_items.find_or_initialize_by(item_id: cart_item_params[:item_id])

    cart_item.quantity += cart_item_params[:quantity].to_i
    cart_item.save!

    head :ok
  rescue ActiveRecord::RecordInvalid
    head :bad_request

  def create
    cart = current_user.cart || Cart.create(user: current_user)
  
    cart_item = cart.cart_items.find_or_initialize_by(item_id: cart_item_params[:item_id])

    cart_item.quantity += cart_item_params[:quantity].to_i
    cart_item.save!

    head :ok
  rescue ActiveRecord::RecordInvalid
    head :bad_request
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: '商品が削除されました。'

  end

  private

  def cart_item_params
    params.permit(:item_id, :quantity)
  end
end
