class PagesController < ApplicationController
  def settings
  end

  def reload
    if current_user.is_root
      @msg = system('git pull o2o master')
    end
  end
end
