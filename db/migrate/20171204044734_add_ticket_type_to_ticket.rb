class AddTicketTypeToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :ticket_type, :integer
  end
end
