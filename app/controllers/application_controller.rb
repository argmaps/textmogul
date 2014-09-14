class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_current_account

private
  def not_authenticated
    redirect_to sign_in_path
  end

  def set_current_account
    @current_account = User.find_by_subdomain(request.subdomains.last)
  end

  def current_account
    @current_account
  end
end
