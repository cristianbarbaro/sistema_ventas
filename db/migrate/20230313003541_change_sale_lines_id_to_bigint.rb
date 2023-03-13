class ChangeSaleLinesIdToBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :sale_lines, :id, :bigint, null: false, unique: true, auto_increment: true
  end
end
