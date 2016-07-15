class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.integer :category_id, null: false

      add_foreign_key :providers, :categories
      t.timestamps
    end
  end
end
