class Price < ApplicationRecord
  has_many :counts

  def desc
    "#{ self.code } - #{ description }"
  end
end
