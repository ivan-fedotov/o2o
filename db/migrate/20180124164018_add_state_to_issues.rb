class AddStateToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :state, :string, default: :new
  end
end
