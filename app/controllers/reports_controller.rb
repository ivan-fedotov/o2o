class ReportsController < ApplicationController
  def new
  end

  def create
    @query = safe_params.to_h
    @tickets = Ticket.where(:time_new => DateTime.parse(@query[:start_time])..DateTime.parse(@query[:end_time]))
    respond_to do |format|
      format.html {}
      format.xls {}
    end
  end

  private

  def safe_params
    params.require(:query).permit(:start_time, :end_time)
  end
end
