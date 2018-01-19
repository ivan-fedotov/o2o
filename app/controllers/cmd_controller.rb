class CmdController < ApplicationController
  def new
  end

  def create
    p prms[:str].to_s
    if current_user.is_root
      result = %x{ #{prms[:str]} }
    end
    @msg = result
    render 'new'
  end

  private

  def prms
    params.require(:cmd).permit(:str)
  end
end
