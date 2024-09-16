module Admin
  class UsersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_user, only: [:show, :edit, :update]

    def index
      @users = User.all
    end

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: 'ユーザー情報が更新されました。'
      else
        render :edit
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :phone_number)
    end
  end
end
