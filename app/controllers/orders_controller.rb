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
    @cart_items = @cart.cart_items.includes(:item) if @cart
    @total_amount = @cart_items.sum { |item| item.quantity * item.item.price } if @cart_items.present?

    @order.total_amount = @total_amount
    @order.address.user = current_user if @order.address.present?

    # addressの保存が行われているか確認
    if @order.address.present? && @order.save
      redirect_to complete_orders_path(@order), notice: '注文が完了しました'
    else
      Rails.logger.info @order.address.errors.full_messages # ここでエラーメッセージを確認
      render :new
    end
  end

  def complete
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      address_attributes: [:postal_code, :prefecture_id, :city, :street, :building_name, :phone_number]
    )
  end
end
