class CreatePasswords < ActiveRecord::Migration[5.1]
  def change
    create_table :passwords do |t|
      t.string :secret
      t.boolean :active
      t.datetime :last_changed

      t.timestamps
    end
  end
end
