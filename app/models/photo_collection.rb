class PhotoCollection < ApplicationRecord
  belongs_to :ticket
  has_many :photos

end
