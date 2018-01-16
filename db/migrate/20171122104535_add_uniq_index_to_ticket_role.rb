class AddUniqIndexToTicketRole < ActiveRecord::Migration[5.1]
  def change
    add_index :ticket_roles, [:user_id, :division_id], :unique => true
  end
end
