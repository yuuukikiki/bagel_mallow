class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: { message: '名前は必須です' }
  validates :email, presence: { message: 'メールアドレスは必須です' },
                    uniqueness: { message: 'このメールアドレスは既に使用されています' },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: '無効なメールアドレスの形式です' }
end
