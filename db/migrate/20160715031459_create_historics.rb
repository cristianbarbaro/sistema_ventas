class CreateHistorics < ActiveRecord::Migration[5.0]
  def change
    create_table :historics do |t|
        t.date :discharge_date, null: false
        t.decimal :cost_price, null: false
        t.integer :article_id, null: false

        add_foreign_key :historics, :articles
        t.timestamps
    end
  end
end
