class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart
  has_many :orders
  has_many :addresses

  validates :name, presence: { message: I18n.t('errors.messages.blank') }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: I18n.t('errors.messages.phone_number') }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/, message: I18n.t('errors.messages.password_invalid') }
  validates :email, presence: { message: I18n.t('errors.messages.blank') },
                    uniqueness: { message: I18n.t('errors.messages.taken') }
end
