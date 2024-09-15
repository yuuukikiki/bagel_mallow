class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  validates :user_id, presence: { message: I18n.t('errors.messages.blank') }

  # アイテムをカートに追加するメソッド
  def add_item(item)
    current_item = cart_items.find_by(item_id: item.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(item_id: item.id, quantity: 0)
    end
    current_item.save
  end

  def total_price
    cart_items.to_a.sum { |item| item.total_price }
  end

  def empty_cart
    cart_items.destroy_all
  end
end
