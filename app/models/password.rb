class Password < ApplicationRecord
  belongs_to :account, dependent: :destroy

  def set_password(str)
    self.secret = encode(str)
    self.save
  end

  def is(str)
    self.secret == encode(str)
  end

  private

  def encode(str)
    Digest::SHA256.hexdigest str
  end
end
