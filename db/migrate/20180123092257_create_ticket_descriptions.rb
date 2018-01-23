class CreateTicketDescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_descriptions do |t|
      t.string :title

      t.timestamps
    end
  end
end
