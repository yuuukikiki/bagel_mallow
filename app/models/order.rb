class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user
  belongs_to :address

  accepts_nested_attributes_for :order_items
  accepts_nested_attributes_for :address

  attr_accessor :token
  validates :address, presence: { message: I18n.t('errors.messages.blank') }
  validates :total_amount, presence: { message: I18n.t('errors.messages.blank') },
                           numericality: { greater_than: 0, message: I18n.t('errors.messages.greater_than') }
end
