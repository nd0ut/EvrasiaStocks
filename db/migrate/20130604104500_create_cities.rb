class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities, { :id => false } do |t|
      t.primary_key :id
      t.string :name
    end
  end
end
