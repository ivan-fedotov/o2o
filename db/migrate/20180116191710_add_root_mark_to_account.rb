class AddRootMarkToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :is_root, :boolean
  end
end
