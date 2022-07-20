class CreateShopOpeningHours < ActiveRecord::Migration[6.1]
  def change
    create_table :shop_opening_hours do |t|
      t.integer :day, null: false
      t.time :open_at, null: false
      t.time :break_starts_at
      t.time :break_ends_at
      t.time :close_at, null: false
      t.references :shop, null: false

      t.timestamps
    end
  end
end
