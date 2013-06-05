class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants, { :id => false } do |t|
      t.primary_key :id
      t.references :city
      t.string :title
      t.string :street
      t.string :metro
      t.string :phone
      t.string :business_hours
    end
  end
end
