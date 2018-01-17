module Current
  thread_mattr_accessor :user
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :get_user
  around_action :get_current_user

  def get_current_user
    Current.user = current_user
    yield
  ensure
    Current.user = nil
  end

  protected
  # Use this in place of params when generating links to Excel etc.
  # See https://github.com/rails/rails/issues/26289
  def safe_params
    params.except(:host, :port, :protocol).permit!
  end
  helper_method :safe_params

end
