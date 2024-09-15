class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.all
  end

  def new
    @order = Order.new
    @order.build_address

    # デバッグ: アドレスがちゃんと作られているか確認
    puts @order.address.inspect

    return unless current_user.orders.any?

    last_order = current_user.orders.order(created_at: :desc).first
    return unless last_order.address

    @order.build_address(last_order.address.attributes.slice(
                           'postal_code', 'prefecture_id', 'city', 'street', 'building_name', 'phone_number'
                         ))
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      redirect_to complete_orders_path, notice: '注文が完了しました'
    else
      render :new
    end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(
      address_attributes: [:postal_code, :prefecture_id, :city, :street, :building_name, :phone_number],
      order_items_attributes: [:item_id, :quantity] # order_items_attributes を追加
    )
  end
end
