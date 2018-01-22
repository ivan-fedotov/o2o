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
    if params[:tt].present? and params[:tt] != ""
      @deadline = params[:tt] == '1' ? Time.now + 4.hours : Time.now + 7.days
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
end
