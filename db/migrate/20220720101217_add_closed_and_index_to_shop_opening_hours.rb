class AddClosedAndIndexToShopOpeningHours < ActiveRecord::Migration[6.1]
  def change
    add_column :shop_opening_hours, :closed, :boolean, default: false

    add_index :shop_opening_hours, [:shop_id, :day], unique: true
  end
end
