class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
        t.integer :current_amount, null: false
        t.integer :minimum_amount, null: false
        t.integer :article_id, null: false

        add_foreign_key :stocks, :articles
        t.timestamps
    end
  end
end
