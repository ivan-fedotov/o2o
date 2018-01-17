require 'digest'

class Account < ApplicationRecord
  has_many :tickets, :foreign_key => 'author_id'
  has_one :password

  before_create do |ac|
    if Account.all.size == 0
      ac.is_root = true
    end
  end
  after_create do |ac|
    p = Password.create(secret: nil, active: false, last_changed: nil, account_id: ac.id)
  end

end
