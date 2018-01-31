class AddTicketIdToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :ticket_id, :integer
  end
end
