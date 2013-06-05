class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks, { :id => false } do |t|
      t.primary_key :id
      t.string :title
      t.text :description
      t.string :image_url
    end
  end
end
