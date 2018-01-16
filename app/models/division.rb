class Division < ApplicationRecord
  has_many :site_roles
  has_many :ticker_roles
  has_many :users, through: :roles

  def self.all_available_to_user(user)
    self.all - user.divisions
  end
end
