class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
        t.string :name, null: false
        t.string :description, null: false
        t.integer :percentage, null: false
        t.decimal :price, null: false
        t.integer :mark_id, null: false
        t.integer :category_id, null: false

        add_foreign_key :articles, :marks
        add_foreign_key :articles, :categories
        t.timestamps
    end
  end
end
