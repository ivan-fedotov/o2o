class AddIsClientAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :is_client, :boolean
  end
end
