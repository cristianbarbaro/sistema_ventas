class CreateHistorics < ActiveRecord::Migration[5.0]
  def change
    create_table :historics do |t|
        t.decimal :cost_price, precision: 9, scale: 2, null: false
        t.belongs_to :article, null: false
        t.timestamps
    end
  end
end
