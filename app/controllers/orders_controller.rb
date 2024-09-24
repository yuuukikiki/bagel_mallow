class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @cart = current_user&.cart
    if @cart.nil? || @cart.cart_items.empty?
      flash[:notice] = "カートは空です"
      @cart_items = [] # カートが空の場合は空の配列をセット
    else
      @cart_items = @cart.cart_items.includes(:item)
    end
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
    Rails.logger.debug "住所オブジェクト: #{@order.address}"

    ActiveRecord::Base.transaction do
      if @order.save
        @cart_items.each do |cart_item|
          @order.order_items.create!(
            item_id: cart_item.item_id,
            quantity: cart_item.quantity,
            price: cart_item.item.price # 必要に応じて price カラムがある場合
          )
        end

        # カートを空にする
        @cart.cart_items.destroy_all

        redirect_to complete_order_path(@order), notice: '注文が完了しました'
      else
        Rails.logger.info @order.address.errors.full_messages
        render 'new', status: :unprocessable_entity
      end
    rescue StandardError => e
      Rails.logger.error "注文処理中にエラーが発生しました: #{e.message}"
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
      address_attributes: %i[user_id postal_code prefecture_id city street building_name phone_number],
      order_items_attributes: %i[item_id quantity]
    )
  end
end
