class AddBrigadeIdToSite < ActiveRecord::Migration[5.1]
  def change
    add_column :sites, :brigade_id, :integer
  end
end
