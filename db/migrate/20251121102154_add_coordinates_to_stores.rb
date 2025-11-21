class AddCoordinatesToStores < ActiveRecord::Migration[8.0]
  def change
    add_column :stores, :latitude, :decimal, precision: 10, scale: 6
    add_column :stores, :longitude, :decimal, precision: 10, scale: 6
    add_column :stores, :space_name, :string
    add_column :stores, :area, :string
    add_column :stores, :hours, :string
  end
end
