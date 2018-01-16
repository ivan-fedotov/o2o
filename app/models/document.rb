class Document < ApplicationRecord
  belongs_to :site
  has_attached_file :file

  attr_accessor :site_filter, :author_filter

  validates_presence_of :file
  do_not_validate_attachment_file_type :file

  scope :existing, -> { where("id IS NOT NULL") }
  scope :sl, -> {where("doctype = 0")}
  scope :sr, -> {where("doctype = 1")}
  scope :ac, -> {where("doctype = 2")}

end
