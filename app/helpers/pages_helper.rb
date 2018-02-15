module PagesHelper
  def tickets_number(brigade, st)
    @t = brigade.tickets
    @t = @t.where("time_new > ?", @start_time) if @start_time
    @t = @t.where("time_new < ?", @end_time) if @end_time
    return @t.status(st).size unless st.nil?
    @t.size
  end

  def status_tickets(st)
    @t = st.tickets
    @t = @t.where("time_new > ?", @start_time) if @start_time
    @t = @t.where("time_new < ?", @end_time) if @end_time
    @t.size
  end
end
