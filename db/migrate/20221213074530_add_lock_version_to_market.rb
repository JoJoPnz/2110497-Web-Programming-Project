class AddLockVersionToMarket < ActiveRecord::Migration[7.0]
  def change
    add_column :markets, :lock_version, :integer
  end
end
