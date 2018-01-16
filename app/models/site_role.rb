class SiteRole < ApplicationRecord
  belongs_to :user
  belongs_to :division

  scope :can_read, -> {where('level > ?', 0)}
  scope :can_read_and_write, -> { where('level > ?', 1) }
end
