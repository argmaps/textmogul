class AdminController < SecureController
  before_filter :require_login
  before_action :set_current_user

  def set_current_user
    User.current = current_user
  end
end
