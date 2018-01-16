class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :network_name
      t.string :adress_info
      t.string :distance
      t.string :access_info
      t.string :keys_info
      t.string :power_info
      t.string :etc

      t.timestamps
    end
  end
end
