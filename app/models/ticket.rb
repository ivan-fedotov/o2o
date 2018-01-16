class Ticket < ApplicationRecord
  include SearchCop

  has_many :messages, :dependent => :destroy do
    def persisted
      collect{ |m| m if m.persisted? }
    end
  end

  has_one :photo_collection
  has_many :photos, through: :photo_collection

  search_scope :search do
    attributes :title, :number
    attributes site: ['site.network_name', 'site.adress_info']
    attributes brigade: ['brigade.title']
  end

  belongs_to :site
  belongs_to :status
  belongs_to :brigade
  belongs_to :ticket_type
  belongs_to :author, :class_name => 'Account', :foreign_key => 'author_id', optional: true
  has_many :counts

  attr_accessor :site_filter, :status_filter, :brigade_filter, :author_filter, :ticket_type_filter, :search_filter, :content

  accepts_nested_attributes_for :counts, allow_destroy: true

  validates :ticket_type_id, presence: true

  scope :status, -> (status) { where status_id: status}
  scope :site, -> (site) {where site_id: site}
  scope :brigade, -> (brigade) {where brigade_id: brigade}
  scope :author, -> (author) {where author_id: author}
  scope :ticket_type, -> (ticket_type) {where ticket_type_id: ticket_type}

  after_create do |t|
    t.number = t.id.to_s.rjust(7, '0')
    t.time_new = t.created_at.localtime
    t.save
    pc = t.create_photo_collection(title: t.number)
    pc.save
  end

  before_save do |t|
    if t.persised?
      str = ""
      t.changes.each do |c|
        case c.first
        when "status_id"
          str += "[ Статус: '#{Status.find(c.last.first).title}' => '#{Status.find(c.last.last).title}' ] "
        when "brigade_id"
          str += "[ Бригада: '#{Brigade.find(c.last.first).title}' => '#{Brigade.find(c.last.last).title}' ] "
        when "time_new"
          str += "[ Время начала: '#{time_f(c.last.first)}' => '#{time_f(c.last.last)}' ] "
        when "time_at_site"
          str += "[ Время регистрации на сайте: '#{time_f(c.last.first)}' => '#{time_f(c.last.last)}' ] "
        when "time_done"
          str += "[ Время окончания работ: '#{time_f(c.last.first)}' => '#{time_f(c.last.last)}' ] "
        when "deadline"
          str += "[ Краний срок: '#{time_f(c.last.first)}' => '#{time_f(c.last.last)}' ] "
        end
      end
      msg = "Изменения: " + str + "" if str.size > 0
      @message = Message.new(content: msg, author_id: 1, ticket_id: t.id)
      @message.save
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |ticket|
        csv << ticket.attributes.values_at(*column_names)
      end
    end
  end

  def time_f(time)
    if time.nil?
      ""
    else
      time.strftime("%d.%m.%Y %H:%M")
    end
  end

end
