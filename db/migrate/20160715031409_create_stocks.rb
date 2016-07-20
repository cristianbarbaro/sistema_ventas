class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
        t.integer :current_amount, null: false
        t.integer :minimum_amount, null: false
        t.belongs_to :article, null: false
        t.timestamps
    end
  end
end
