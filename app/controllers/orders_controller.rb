class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:item) if @cart
    @items = Item.all
  end

  def new
    @order = Order.new
    @order.build_address

    # Calculate total amount from cart items
    @total_amount = current_user.cart.cart_items.sum { |cart_item| cart_item.item.price * cart_item.quantity }

    return unless current_user.orders.any?

    last_order = current_user.orders.order(created_at: :desc).first
    return unless last_order.address

    @order.build_address(last_order.address.attributes.slice(
                           'postal_code', 'prefecture_id', 'city', 'street', 'building_name', 'phone_number'
                         ))
  end

  def create
    @order = current_user.orders.build(order_params)
    @cart = current_user.cart
    @total_amount = @cart.cart_items.sum { |item| item.quantity * item.item.price }

    @order.total_amount = @total_amount

    if @order.save
      redirect_to complete_orders_path(@order), notice: '注文が完了しました'
    else
      render :new
    end
  end

  def complete
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      address_attributes: [:postal_code, :prefecture_id, :city, :street, :building_name, :phone_number],
      order_items_attributes: [:item_id, :quantity]
    )
  end
end
