require 'rails_helper'

RSpec.describe CartItem, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @cart = FactoryBot.create(:cart, user: @user)
    @cart_item = FactoryBot.build(:cart_item, cart: @cart, item: @item)
  end

  describe 'カートアイテムの作成' do
    context 'カートアイテムが作成できるとき' do
      it 'カートとアイテムが関連付けられていれば作成できる' do
        expect(@cart_item).to be_valid
      end
    end

    context 'カートアイテムが作成できないとき' do
      it 'カートが関連付けられていないと作成できない' do
        @cart_item.cart = nil
        @cart_item.valid?
        expect(@cart_item.errors.full_messages).to include('Cartを入力してください')
      end

      it 'アイテムが関連付けられていないと作成できない' do
        @cart_item.item = nil
        @cart_item.valid?
        expect(@cart_item.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
