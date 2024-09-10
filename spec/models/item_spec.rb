require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'アイテムの登録' do
    context 'アイテムが登録できるとき' do
      it '全ての必須項目が正しく入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context 'アイテムが登録できないとき' do
      it '名前が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include(I18n.t('errors.messages.blank'))
      end

      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end
