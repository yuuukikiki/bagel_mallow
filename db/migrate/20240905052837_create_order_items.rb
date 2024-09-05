class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order,null: false,foreign_key: true, type: :bigint
      t.references :item,null: false,foreign_key: true, type: :bigint
      t.integer :quantity,null: false
      t.integer :price,null: false
      t.timestamps
    end
  end
end