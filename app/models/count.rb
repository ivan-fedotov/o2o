class Count < ApplicationRecord
  belongs_to :price
  belongs_to :ticket, inverse_of: :counts

  after_create do |c|
    c.price_on_init = c.price.price
    c.save
  end
end
