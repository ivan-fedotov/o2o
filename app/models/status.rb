class Status < ApplicationRecord
  has_many :role_permissions

  default_scope { order(:position) }
end
