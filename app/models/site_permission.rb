class SitePermission < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :division, dependent: :destroy
end
