class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @order.build_address # Addressオブジェクトの初期化
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to complete_orders_path, notice: '注文が正常に作成されました。'
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
      order_items_attributes: [:item_id, :quantity] # 商品情報のネストされた属性をパーミット
    )
  end
end
