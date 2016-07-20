class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
        t.decimal :total_price, precision: 9, scale: 2, null: false
        t.timestamps
    end
  end
end
