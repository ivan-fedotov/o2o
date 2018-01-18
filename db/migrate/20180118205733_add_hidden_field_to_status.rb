class AddHiddenFieldToStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :statuses, :is_first, :boolean
    add_column :statuses, :is_hidden, :boolean
  end
end
