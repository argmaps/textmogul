class PagesController < SecureController
  include HighVoltage::StaticPage
  before_action :redirect_authenticated_from_home_to_dashboard

  def show
    if params[:id] == 'home' and current_account and not current_user
      @subscriber = Subscriber.new
      @subscriber.build_subscription
      render 'accounts/home', layout: 'end_user'
    else
      super
    end
  end


private
  def redirect_authenticated_from_home_to_dashboard
    redirect_to broadcasts_path if params[:id] == 'home' and current_user
  end
end
