require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'バリデーションテスト' do
    before do
      @admin = Admin.new(
        name: '管理者',
        email: 'admin@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it '有効な場合は保存されること' do
      expect(@admin).to be_valid
    end

    context '名前が空の場合' do
      before do
        @admin.name = ''
        @admin.valid?
      end

      it '無効であること' do
        expect(@admin.errors[:name]).to include('名前は必須です')
      end
    end

    context 'メールアドレスが空の場合' do
      before do
        @admin.email = ''
        @admin.valid?
      end

      it '無効であること' do
        expect(@admin.errors[:email]).to include('メールアドレスは必須です')
      end
    end

    context 'メールアドレスが重複する場合' do
      before do
        Admin.create(
          name: '既存の管理者',
          email: 'duplicate@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        )
        @admin.email = 'duplicate@example.com'
        @admin.valid?
      end

      it '無効であること' do
        expect(@admin.errors[:email]).to include('このメールアドレスは既に使用されています')
      end
    end

    context '無効なメールアドレス形式の場合' do
      before do
        @admin.email = 'invalid-email'
        @admin.valid?
      end

      it '無効であること' do
        expect(@admin.errors[:email]).to include('無効なメールアドレスの形式です')
      end
    end
  end
end
