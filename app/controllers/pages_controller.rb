class PagesController < ApplicationController
  def settings
  end

  def reload
    if current_user.is_root
      system "cd /date/www/o2o/o2o/; git pull o2o master;"
    end
  end
end
