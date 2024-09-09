class Item < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :name, presence: { message: I18n.t('errors.messages.blank') }
  validates :description, presence: { message: I18n.t('errors.messages.blank') }
  validates :price, presence: { message: I18n.t('errors.messages.blank') },
                    numericality: { only_integer: true, greater_than: 0, message: I18n.t('errors.messages.greater_than') }
  validates :image_url, presence: { message: I18n.t('errors.messages.blank') }
end
