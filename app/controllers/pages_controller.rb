class PagesController < ApplicationController
  def settings
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
