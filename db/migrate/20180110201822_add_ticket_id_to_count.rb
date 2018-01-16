class AddTicketIdToCount < ActiveRecord::Migration[5.1]
  def change
    add_column :counts, :ticket_id, :integer
  end
end
