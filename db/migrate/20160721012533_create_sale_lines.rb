class CreateSaleLines < ActiveRecord::Migration[5.0]
  def change
    create_table :sale_lines do |t|
        t.belongs_to :sale, null: false
        t.belongs_to :article, null: false
        t.integer :article_amount, null: false
        t.decimal :article_final_price_unit, precision: 9, scale: 2, null: false
        t.timestamps
    end
  end
end
