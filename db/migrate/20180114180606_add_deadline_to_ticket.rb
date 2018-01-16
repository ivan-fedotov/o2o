class AddDeadlineToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :deadline, :datetime
  end
end
