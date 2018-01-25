class Issue < ApplicationRecord
  before_create :set_time_deadline

  state_machine :state, initial: :new do

    after_transition :on => :reinit, :do => :set_time_init

    event :start do
      transition :new => :progress
    end

    event :reinit do
      transition :progress => :new
    end

    state :new do
    end

    state :progress do
      validates_presence_of :title, :time_new, :time_deadline
    end

  end

  def initialize(args)
    super(args)
    self.time_new = Time.now
    self.num = 2
  end

  def set_time_init
    puts "set_time_init"
  end

  private

  def set_time_deadline
    puts "set time deadline"
    time_additional = self.num == 1 ? 4.days : 5.hours
    self.time_deadline = self.time_new + time_additional
  end

end
