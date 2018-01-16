class Account < ApplicationRecord
  has_many :tickets, :foreign_key => 'author_id'
end
