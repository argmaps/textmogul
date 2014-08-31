class PagesController < SecureController
  include HighVoltage::StaticPage
  before_action :redirect_authenticated_from_home_to_dashboard


private
  def redirect_authenticated_from_home_to_dashboard
    redirect_to dashboard_path if params[:id] == 'home' and current_user
  end
end
