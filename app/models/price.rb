class Price < ApplicationRecord
  has_many :counts

  def desc
    "#{ id } - #{description}"
  end
end
