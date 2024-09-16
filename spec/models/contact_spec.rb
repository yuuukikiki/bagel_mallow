require 'rails_helper'

RSpec.describe Contact, type: :model do
  before do
    @contact = FactoryBot.build(:contact)
  end

  describe 'お問い合わせの送信' do
    context 'お問い合わせが送信できるとき' do
      it '全ての必須項目が正しく入力されていれば送信できる' do
        expect(@contact).to be_valid
      end
    end

    context 'お問い合わせが送信できないとき' do
      it '名前が空では送信できない' do
        @contact.name = ''
        @contact.valid?
        expect(@contact.errors.full_messages).to include('Nameは必須です')
      end

      it 'メールアドレスが空では送信できない' do
        @contact.email = ''
        @contact.valid?
        expect(@contact.errors.full_messages).to include('Emailは必須です')
      end

      it '無効なメールアドレスでは送信できない' do
        @contact.email = 'invalid_email'
        @contact.valid?
        expect(@contact.errors.full_messages).to include('Emailは無効なメールアドレスです')
      end

      it 'メッセージが空では送信できない' do
        @contact.message = ''
        @contact.valid?
        expect(@contact.errors.full_messages).to include('Messageは必須です')
      end
    end
  end
end
