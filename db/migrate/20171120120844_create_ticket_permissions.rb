class CreateTicketPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_permissions do |t|
      t.integer :user_id
      t.integer :division_id
      t.integer :role

      t.timestamps
    end
  end
end
