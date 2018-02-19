class Photo < ApplicationRecord
  belongs_to :site, optional: true
  belongs_to :message, optional: true
  belongs_to :photo_collection, optional: true
  has_attached_file :image, :styles => { :thumb => "220x220>" }

  attr_accessor :site_filter, :author_filter

  validates_presence_of :image
  validates_attachment :image, :presence => true, :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }

  scope :existing, -> { where("id IS NOT NULL") }
  scope :site_photos, -> {where("message_id IS NULL")}
  scope :no_pc, -> {where("photo_collection_id IS NULL")}
end
