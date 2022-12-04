class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.decimal :price
      t.integer :qty
      t.datetime :timestamp

      t.timestamps
    end
  end
end
