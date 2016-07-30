class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
        t.integer :code, unique: true, null: false
        t.string :name, null: false
        t.string :description
        t.integer :percentage, null: false
        t.decimal :cost_price, precision: 9, scale: 2, null: false
        t.decimal :final_price, precision: 9, scale: 2, null: false
        t.belongs_to :mark, null: false
        t.belongs_to :category, null: false
        t.timestamps
    end
  end
end
1000000
