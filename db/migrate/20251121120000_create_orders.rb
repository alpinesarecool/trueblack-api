class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :table_number, null: false
      t.timestamps
    end
  end
end
