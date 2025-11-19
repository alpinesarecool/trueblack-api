class CreateMenuItems < ActiveRecord::Migration[8.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.references :category, null: false, foreign_key: true
      t.string :image_url
      t.boolean :is_available

      t.timestamps
    end
  end
end
