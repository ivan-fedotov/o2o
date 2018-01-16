class AddBrigadeIdToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :brigade_id, :integer
  end
end
