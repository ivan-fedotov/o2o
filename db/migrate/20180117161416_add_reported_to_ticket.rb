class AddReportedToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :reported, :boolean
  end
end
