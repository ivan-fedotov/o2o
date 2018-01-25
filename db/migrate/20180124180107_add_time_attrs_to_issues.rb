class AddTimeAttrsToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :time_new, :datetime
    add_column :issues, :time_registration_at_site, :datetime
    add_column :issues, :time_finish, :datetime
    add_column :issues, :time_deadline, :datetime
  end
end
