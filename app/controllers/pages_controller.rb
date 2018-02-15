class PagesController < ApplicationController
  def settings
    @account = current_user
    @password = @account.password
  end

  def get_sites
    if params[:site_srch].present? and params[:site_srch] != ""
      @sites = Site.search(params[:site_srch])
    else
      @sites = Site.all
    end
    render :nothing => true
  end

  def get_deadline
    @site = Site.find(params[:site]) if params[:site].present? and params[:site] != ""
    @deadline = nil if @site.nil?

    if params[:tt].present? and params[:tt] != ""
      if @site.nil?
        @deadline = nil
      else
        @deadline = params[:tt] == '1' ? Time.now + (1.hour + (@site.distance.to_f/60.to_f).hours) : Time.now + 3.days
      end
    end
    render :nothing => true
  end

  def reload
    if current_user.is_root
      system "cd /data/www/o2o/o2o; git pull o2o master;"
    end
  end

  def new_db
    if current_user.is_root
      system "cd /data/www/o2o/o2o; rake db:schema:load; rake db:seed;"
    end
  end

  def statistics
    @start_time = DateTime.parse(params[:query][:start_time]) if params[:query] and params[:query][:start_time] != ""
    @end_time = DateTime.parse(params[:query][:end_time]) if params[:query] and params[:query][:end_time] != ""
    @brigades = Brigade.order("title asc")
    #@brigades = @brigades.search(params[:brigade][:search_filter]) if params[:brigade].present? and params[:brigade][:search_filter].present?
    @statuses = Status.all
    @tickets = Ticket.all
    @tickets_finished = @tickets.where("time_done > ?", @start_time) if @start_time
    @tickets_finished = @tickets.where("time_done < ?", @end_time) if @end_time

    @tickets = @tickets.where("time_new > ?", @start_time) if @start_time
    @tickets = @tickets.where("time_new < ?", @end_time) if @end_time
  end
end
