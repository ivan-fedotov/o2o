class Role < ApplicationRecord
  has_many :role_permissions
  has_and_belongs_to_many :accounts, :through => :accounts_roles

  after_create do |r|

    Status.all.each do |s|
    #Status.active.each do |s|
      rp = r.role_permissions.new(status_id: s.id)
      rp.permissions = '{"view_photo_report"=>"1", "edit_photo_report"=>"1", "edit_ticket_type"=>"0", "edit_ticket_site"=>"0", "edit_ticket_title"=>"0", "edit_ticket_status"=>"0", "edit_ticket_brigade"=>"0", "edit_ticket_author"=>"0", "edit_ticket_time_new"=>"0", "edit_ticket_deadline"=>"0", "edit_ticket_time_at_site"=>"0", "edit_ticket_time_done"=>"0", "see_calculation"=>"1", "edit_calculation"=>"0", "edit_expences_type"=>"1", "see_chronology"=>"1", "edit_chronology"=>"1", "change_is_opex"=>"1"}'
      rp.save
    end
    r.role_permissions.new(status_id: nil)
    r.permissions = '{"edit_permissions"=>"0", "edit_roles"=>"0", "edit_statuses"=>"0", "edit_ticket_types"=>"0", "edit_accounts"=>"0", "get_reports"=>"0", "edit_prices"=>"0", "edit_brigades"=>"1", "see_brigade"=>"1", "see_site"=>"1", "edit_sites"=>"0", "view_docs"=>"1", "edit_docs"=>"1", "open_ticket"=>"1", "see_ticket"=>"1", "edit_ticket"=>"1", "send_ticket_message"=>"0", "see_reported"=>"1"}'
    r.save
  end
end
