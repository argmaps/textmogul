class UsersController < AdminController
  skip_before_action :require_login, :set_current_user, only: [:new, :create]

  def edit
    @user = current_user
  end

  def update
    @user = User.find_by_id!(params[:id])

    respond_to do |format|
      if @user.update_attributes(adapted_params)
        format.html { flash.now['success'] = 'Updated settings.'; render :edit }
      else
        format.html { flash.now['danger'] = "Encountered an error in updating."; render :edit }
      end
    end
  end

private
  def adapted_params
    params.require(:user).permit(:email, :password, :subdomain, :stripe_secret_key, :stripe_publishable_key)
  end
end
