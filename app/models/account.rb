require 'digest'

class Account < ApplicationRecord
  has_many :tickets, :foreign_key => 'author_id'
  has_one :password

  after_create do |ac|
    p = Password.create(secret: nil, active: false, last_changed: nil, account_id: ac.id)
  end

end
