class TicketRole < ApplicationRecord

  belongs_to :user, dependent: :destroy
  belongs_to :division, dependent: :destroy

  scope :can_read, -> {where('level > ?', 0)}
  scope :can_read_and_write, -> { where('level > ?', 1) }
end
