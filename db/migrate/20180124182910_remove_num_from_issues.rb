class RemoveNumFromIssues < ActiveRecord::Migration[5.1]
  def change
    remove_column :issues, :num, :integer
    remove_column :issues, :workflow_state, :string
    remove_column :issues, :title, :string
    add_column :issues, :ticket_description_id, :integer
    add_column :issues, :responsible, :integer
    add_column :issues, :brigade_id, :integer
    add_column :issues, :chrono, :string
    add_column :issues, :ticket_type_id, :integer
  end
end
