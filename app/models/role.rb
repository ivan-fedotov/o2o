class Role < ApplicationRecord
  has_many :role_permissions
  has_and_belongs_to_many :accounts, :through => :accounts_roles

  after_create do |r|
    Status.all.each do |s|
    #Status.active.each do |s|
      rp = r.role_permissions.new(status_id: s.id)
      rp.save
    end
  end
end
