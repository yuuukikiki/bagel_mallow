require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @order = FactoryBot.build(:order, user: @user)
  end

  describe '注文の作成' do
    context '注文が作成できるとき' do
      it 'ユーザーが関連付けられていれば作成できる' do
        expect(@order).to be_valid
      end
    end

    context '注文が作成できないとき' do
      it 'ユーザーが関連付けられていないと作成できない' do
        @order.user = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('Userは必須です')
      end

      it '配送先住所が空では作成できない' do
        @order.delivery_address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end
