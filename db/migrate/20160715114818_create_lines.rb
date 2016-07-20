class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
        t.belongs_to :sale, null: false
        t.belongs_to :article, null: false
        t.integer :article_amount, null: false
        t.decimal :article_final_price_unit, null: false
        t.timestamps
    end
  end
end
