class Price < ApplicationRecord
  has_many :counts

  def desc
    "#{ code } - #{description}"
  end
end
