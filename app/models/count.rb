class Count < ApplicationRecord
  belongs_to :price
  belongs_to :ticket, inverse_of: :counts

  after_create do |c|
    c.price_on_init = c.price.price
    c.is_opex = 0
    c.quantity = 1 if c.price.code == 0
    c.save
  end
end
