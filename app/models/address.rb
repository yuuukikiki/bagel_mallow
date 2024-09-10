class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :prefecture
  belongs_to :user
  has_many :orders

  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: I18n.t('errors.messages.postal_code_invalid') }
  validates :city, presence: { message: I18n.t('errors.messages.blank') }
  validates :street, presence: { message: I18n.t('errors.messages.blank') }
  validates :prefecture_id, numericality: { other_than: 1, message: I18n.t('errors.messages.prefecture') }
end
