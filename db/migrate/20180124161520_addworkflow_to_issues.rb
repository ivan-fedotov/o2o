class AddworkflowToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :workflow_state, :string
  end
end
