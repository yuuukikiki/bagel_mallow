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
    @order = Order.new(order_params)

    if @order.valid?
      # PAY.JPのAPIキーをセット
      Payjp.api_key = 'sk_test_21e93a33367464941ff66034' # 自分のPAY.JPテスト秘密鍵を設定

      # PAY.JPで決済処理を実行
      Payjp::Charge.create(
        amount: order_params[:price],  # 商品の値段
        card: order_params[:token],    # フロントエンドで生成されたトークン
        currency: 'jpy'                # 日本円
      )

      # 注文を保存
      @order.save
      redirect_to root_path, notice: '注文が完了しました'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :price, # カート内の商品合計金額
      address_attributes: [:postal_code, :prefecture_id, :city, :street, :building_name, :phone_number],
      order_items_attributes: [:item_id, :quantity]
    ).merge(token: params[:token]) # フロントエンドから送信されたトークンをマージ
  end
end
