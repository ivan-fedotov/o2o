require 'digest'

class Account < ApplicationRecord
  has_one :password
  has_many :tickets, :foreign_key => 'author_id'
  has_many :account_roles
  has_and_belongs_to_many :roles, :through => :accounts_roles

  attr_accessor :prms, :status_id

  before_create do |ac|
    if Account.all.size == 0
      ac.is_root = true
    end
    ac.email.downcase!
  end
  after_create do |ac|
    p = Password.create(secret: nil, active: false, last_changed: nil, account_id: ac.id)
  end

  def can?(key)
    can_st(key, nil)
  end

  def can_st(key, s)
    return true if self.is_root == true
    ar = prms
    return false if ar == ([] or nil)
    ar.key?(key) ? ar[key] : false
  end

  private

  def prms
    result = []
    s = status_id
    p "STATUS - #{ self.roles }"
    return result if self.roles.size == 0
    self.roles.each do |role|
      p_str = role.role_permissions.where(status_id: s).first.permissions
      result << eval(p_str)
    end
    conjunc_array result
  end

  def conjunc_couple( hash1, hash2 )
    result = hash1
    result.each do |k, v|
      result[k] = (v | hash2[k]) if hash2.key?(k)
      hash2.delete(k)
    end
    result.update(hash2) if hash2.size > 0
  end

  def conjunc_array(arr)
    result = arr.shift
    arr.each do |a|
      conjunc_couple(result, a)
    end
    p "DATA - #{ result }"
    result
  end
end
