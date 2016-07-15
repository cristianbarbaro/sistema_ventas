class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
        t.integer :sale_id, null: false
        t.integer :article_id, null: false
        t.integer :article_amount, null: false
        t.decimal :article_final_price_unit, null: false

        add_foreign_key :lines, :sales
        add_foreign_key :lines, :articles
        t.timestamps
    end
  end
end
