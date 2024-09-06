class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @order = Order.new
    @order.build_address
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      redirect_to @order, notice: '注文が完了しました'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :item_id, # アイテムのID、適宜追加
      address_attributes: [:postal_code, :prefecture_id, :city, :street, :building_name, :phone_number]
    )
  end
end
