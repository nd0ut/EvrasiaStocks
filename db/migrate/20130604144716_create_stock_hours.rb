class CreateStockHours < ActiveRecord::Migration
  def change
    create_table :stock_hours do |t|
      t.references :stock
      t.references :restaurant
      t.string :hours
    end
  end
end
