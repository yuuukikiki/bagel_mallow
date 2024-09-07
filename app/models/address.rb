class Address < ApplicationRecord
  belongs_to :user
  has_many :orders
  belongs_to_active_hash :prefecture
end
