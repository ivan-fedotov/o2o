class Price < ApplicationRecord
  has_many :counts

  default_scope {order("code asc")}
  def desc
    "#{ self.text_code } - #{ description }"
  end
end
