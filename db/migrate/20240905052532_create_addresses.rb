class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code,null: false
      t.string :city,null: false
      t.string :street,null: false
      t.string :building_name,null: true
      t.references :user,null: false,foreign_key: true
      t.integer :prefecture_id,null: false
      t.timestamps
    end
  end
end