class ReportsController < ApplicationController
  include ApplicationHelper

  before_action do
    check_permissions(:see_reports)
  end

  def new
  end

  def create
    @query = query_params.to_h
    @tickets = Ticket.where(:time_done => DateTime.parse(@query[:start_time])..DateTime.parse(@query[:end_time]))
    respond_to do |format|
      format.html { }
      format.xls { }
    end
  end

  private

  def query_params
    params.require(:query).permit(:start_time, :end_time)
  end
end
