class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :contact
      t.belongs_to :category, null: false
      t.timestamps
    end
  end
end
