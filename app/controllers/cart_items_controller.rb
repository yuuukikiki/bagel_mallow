class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = current_user.cart || Cart.create(user: current_user)
    # 指定された商品がカートに入っていればそのカートを取得、入っていなければ新しく作成
    cart_item = cart.cart_items.find_or_initialize_by(item_id: cart_item_params[:item_id])

    # カートに入っている商品の数量を更新
    cart_item.quantity += cart_item_params[:quantity].to_i
    cart_item.save!

    # js側でアラートを表示するのでステータスだけ返す
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
