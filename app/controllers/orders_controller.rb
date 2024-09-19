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

    # 現在のユーザーのカートを取得
    @cart = current_user.cart
    if @cart.present?
      @cart_items = @cart.cart_items.includes(:item) # カート内の商品を取得
      @total_amount = @cart_items.sum { |cart_item| cart_item.item.price * cart_item.quantity } # 合計金額を計算
    else
      @cart_items = [] # カートが空の場合は空の配列をセット
      @total_amount = 0
    end

    # 過去の注文情報を使って住所を自動入力
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
    @cart_items = @cart.cart_items.includes(:item) if @cart # ここでカートアイテムを再設定
    @total_amount = @cart_items.sum { |item| item.quantity * item.item.price } if @cart_items.present?
    @order = Order.new(order_params)
    @order.total_amount = @total_amount

    if @order.save
      # カートの中身を空にするなどの処理を追加する場合も
      redirect_to complete_orders_path(@order), notice: '注文が完了しました'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
        address_attributes: [:postal_code, :prefecture_id, :city, :street, :building_name, :phone_number],
      order_items_attributes: [:item_id, :quantity]
    )
  end
end
