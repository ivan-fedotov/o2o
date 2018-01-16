class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :get_user

  protected
  # Use this in place of params when generating links to Excel etc.
  # See https://github.com/rails/rails/issues/26289
  def safe_params
    params.except(:host, :port, :protocol).permit!
  end
  helper_method :safe_params

end
