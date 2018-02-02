class ReportsController < ApplicationController
  include ApplicationHelper

  before_action :get_permissions

  def new
  end

  def create
    @query = query_params.to_h
    @tickets = Ticket.where(:time_done => DateTime.parse(@query[:start_time])..DateTime.parse(@query[:end_time]), :status_id => 8..9).reject {|t| t.counts.size < 1}
    respond_to do |format|
      format.html { }
      format.xls { }
    end
  end

  private

  def query_params
    params.require(:query).permit(:start_time, :end_time)
  end

  def get_permissions
    raise ActionController::RoutingError.new('Not Found') unless current_user.can?('get_reports')
  end

end
