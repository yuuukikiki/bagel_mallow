class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def order_history
    @orders = current_user.orders.order(created_at: :desc) # 最新の注文が上に来るように
  end
end
