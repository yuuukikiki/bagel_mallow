require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての必須項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Nameは必須です')
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Emailは必須です')
      end

      it 'phone_numberが無効な形式では登録できない' do
        @user.phone_number = '123456789' # 無効な形式
        @user.valid?
        expect(@user.errors.full_messages).to include('Phone numberは10桁または11桁の数字でなければなりません')

        @user.phone_number = '09012345678' # 有効な形式
        expect(@user).to be_valid
      end

      it 'passwordが英字と数字を含まない場合は登録できない' do
        @user.password = 'password' # 数字が含まれていない
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordは英字と数字を含む必要があります')

        @user.password = 'pass1234' # 正しい形式
        expect(@user).to be_valid
      end

      it 'emailが重複している場合は登録できない' do
        FactoryBot.create(:user, email: @user.email)
        @user.valid?
        expect(@user.errors.full_messages).to include('Emailはすでに登録されています')
      end
    end
  end
end
