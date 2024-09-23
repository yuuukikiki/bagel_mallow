class RemoveOrderIdFromAddress < ActiveRecord::Migration[7.0]
  def change
    remove_column :addresses, :order_id, :integer
  end
end
