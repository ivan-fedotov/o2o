class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :name_long
      t.boolean :is_service
      t.string :password

      t.timestamps
    end
  end
end
