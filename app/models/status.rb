class Status < ApplicationRecord
  has_many :role_permissions
  has_many :tickets

  default_scope { order(:position) }
end
