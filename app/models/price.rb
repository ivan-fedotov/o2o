class Price < ApplicationRecord
  has_many :counts

  default_scope {order("code asc")}
  def desc
    "#{ self.code } - #{ description }"
  end
end
