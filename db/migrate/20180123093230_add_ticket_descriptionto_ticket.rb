class AddTicketDescriptiontoTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :ticket_description_id, :integer
  end
end
