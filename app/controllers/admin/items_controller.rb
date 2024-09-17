module Admin
  class ItemsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_item, only: [:show, :edit, :update, :destroy]

    def index
      @items = Item.all
    end

    def show
    end

    def new
      @item = Item.new
    end

    def create
      @item = Item.new(item_params)
      if @item.save
        redirect_to admin_item_path(@item), notice: '商品が作成されました。'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @item.update(item_params)
        redirect_to admin_item_path(@item), notice: '商品が更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @item.destroy
      redirect_to admin_items_path, notice: '商品が削除されました。'
    end

    private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description, :price, :image_url)
    end
  end
end
