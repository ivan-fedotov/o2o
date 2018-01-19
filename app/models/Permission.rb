class Permission
  attr_accessor :list, :values
  attr_reader :size

  def initialize(str)
    @size = 0
    if str.nil?
      instance_variable_set("@size", 0)
      return {}
    end
    h = eval(str.to_s)
    @list = []
    h.each do |k, v|
      var_name = "@#{k.to_s}"
      instance_variable_set(var_name, v)
      @list << k
      @size += 1
    end
    to_string
  end

  def size
    @size
  end

  def prms(name)
    instance_variable_get("@#{name}")
  end

  def to_string
    result = Hash.new
    list.each do |l|
      var_name = "@#{l.to_s}"
      result[l] = instance_variable_get(var_name)
    end
    result
  end

  private

end
