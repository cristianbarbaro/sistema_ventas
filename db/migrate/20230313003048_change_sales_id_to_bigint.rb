class ChangeSalesIdToBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :sales, :id, :bigint, null: false, unique: true, auto_increment: true
  end
end
