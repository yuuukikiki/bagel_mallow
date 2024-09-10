require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before do
    @order = FactoryBot.create(:order)
    @item = FactoryBot.create(:item)
    @order_item = FactoryBot.build(:order_item, order: @order, item: @item)
  end

  describe '注文アイテムの作成' do
    context '注文アイテムが作成できるとき' do
      it '注文とアイテムが関連付けられていれば作成できる' do
        expect(@order_item).to be_valid
      end
    end

    context '注文アイテムが作成できないとき' do
      it '注文が関連付けられていないと作成できない' do
        @order_item.order = nil
        @order_item.valid?
        expect(@order_item.errors.full_messages).to include('Orderを入力してください')
      end

      it 'アイテムが関連付けられていないと作成できない' do
        @order_item.item = nil
        @order_item.valid?
        expect(@order_item.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
