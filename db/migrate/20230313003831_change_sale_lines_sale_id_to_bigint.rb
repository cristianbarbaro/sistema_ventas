class ChangeSaleLinesSaleIdToBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :sale_lines, :sale_id, :bigint, null: false
  end
end
