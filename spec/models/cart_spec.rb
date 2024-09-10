require 'rails_helper'

RSpec.describe Cart, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @cart = FactoryBot.build(:cart, user: @user)
  end
  describe 'カートの作成' do
    context 'カートが作成できるとき' do
      it 'ユーザーが関連付けられていればカートが作成できる' do
        expect(@cart).to be_valid
      end
    end

    context 'カートが作成できないとき' do
      it 'ユーザーが関連付けられていないと作成できない' do
        @cart.user = nil
        @cart.valid?
        expect(@cart.errors.full_messages).to include('Userは必須です')
      end
    end
  end
end
