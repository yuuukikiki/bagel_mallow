class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :quantity, presence: { message: I18n.t('errors.messages.blank') },
                       numericality: { only_integer: true, greater_than: 0, message: I18n.t('errors.messages.greater_than_or_equal_to') }
end
