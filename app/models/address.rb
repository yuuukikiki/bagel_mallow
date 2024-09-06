class Address < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to_active_hash :prefecture
end
