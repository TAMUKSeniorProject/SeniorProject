class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :replies, :content, :reply
  end
end
