class AddNumberToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :number, :string
  end
end
