require 'digest'

class Account < ApplicationRecord
  has_one :password
  has_many :tickets, :foreign_key => 'author_id'
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

  def statuses(s)
    result = []
    self.roles.each do |role|
      role_permission = role.role_permissions.where(status_id: s).first
      str = role_permission.statuses unless role_permission.nil?
      result << eval(str) unless str == "" or str.nil?
    end
    result.flatten.uniq
  end

  def can?(key)
    can_st?(key, nil)
  end

  def can_st?(key, s)
    return true if self.is_root == true

    ar = (!@param_str.nil?) ? @param_str : prms(s)
    #p ar
    return false if ar == [] or ar.nil?

    result = ar.key?(key) ? ar[key] : false
    result == '1' ? true : false
  end

  private

  def prms(s)
    result = []
    return result if self.roles.size == 0

    statuses = []
    statuses << nil
    statuses << s unless s.nil?
    self.roles.each do |role|
      statuses.each do |stat|
        rprms = role.role_permissions.where(status_id: stat).first
        p_str = rprms.permissions unless rprms.nil?
        #p "PERMISSIONS - #{ p_str }"
        result << eval(p_str) unless p_str == "" or p_str.nil?
      end
    end
    p "arrays - #{result.size}"
    @param_str = conjunc_array(result)
    #p "PARAM STRING - #{@param_str.size}"
    @param_str
  end

  def conjunc_couple( hash1, hash2 )
    result = hash1
    result.each do |k, v|
      result[k] = (hash2.key?(k) and hash2[k] == '1') ? '1' : v
      p "#{k}: h1 - #{v} :: h2 - #{ hash2[k] }"
      p "        result: #{ result[k] }"
      hash2.delete(k)
    end
    result.update(hash2) if hash2.size > 0
    result
  end

  def conjunc_array(arr)
    result = arr.shift
    arr.each do |a|
      result = conjunc_couple(result, a)
    end
    #p "DATA - #{ result }"
    result
  end
end
