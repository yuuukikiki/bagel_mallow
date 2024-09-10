require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end

  describe '住所の登録' do
    context '新規登録できるとき' do
      it '全ての必須項目が正しく入力されていれば登録できる' do
        expect(@address).to be_valid
      end
    end

    context '新規登録できないとき' do
      it '郵便番号が空では登録できない' do
        @address.postal_code = ''
        @address.valid?
        expect(@address.errors.full_messages).to include('Postal codeは無効です。ハイフン(-)を含めてください')
      end

      it '市区町村が空では登録できない' do
        @address.city = ''
        @address.valid?
        expect(@address.errors.full_messages).to include('Cityは必須です')
      end

      it '番地が空では登録できない' do
        @address.street = ''
        @address.valid?
        expect(@address.errors.full_messages).to include('Streetは必須です')
      end

      it '都道府県が選択されていない場合登録できない' do
        @address.prefecture_id = 1
        @address.valid?
        expect(@address.errors.full_messages).to include('Prefectureを選択してください')
      end
    end
  end
end
