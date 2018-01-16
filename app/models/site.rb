class Site < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :network_name, :adress_info
    attributes brigade: ['brigade.title']
  end

  has_many :tickets
  has_many :photo_collections, through: :tickets
  has_many :photos do
    def persisted
      collect{ |m| m if m.persisted? }
    end
  end

  has_many :documents do
    def persisted
      collect{ |m| m if m.persisted? }
    end
  end

  belongs_to :brigade

  attr_accessor :brigade_filter, :search_filter

  scope :brigade, -> (brigade) {where brigade_id: brigade}

  def description
    "#{ network_name } - #{ adress_info }"
  end
end
