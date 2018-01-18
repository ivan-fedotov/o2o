class RolePermission < ApplicationRecord
  belongs_to :role
  belongs_to :status, optional: true

  validates :role_id, presence: true
end
