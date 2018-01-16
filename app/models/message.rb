class Message < ApplicationRecord
  has_many :photos
  belongs_to :ticket, dependent: :destroy
  belongs_to :author, class_name: 'Account', foreign_key: 'author_id'

  accepts_nested_attributes_for :photos

end
