class AddAccountIdToPassword < ActiveRecord::Migration[5.1]
  def change
    add_column :passwords, :account_id, :integer
  end
end
