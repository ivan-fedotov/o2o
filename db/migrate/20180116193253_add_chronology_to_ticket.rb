class AddChronologyToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :chrono, :string
  end
end
