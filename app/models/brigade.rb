class Brigade < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :title, :description
    attributes site: ['sites.network_name', 'sites.adress_info']
  end

  attr_accessor :search_filter

  has_many :tickets
  has_many :sites

  def free?
    self.tickets.size == self.sites.size and self.tickets.size == 0
  end
end
