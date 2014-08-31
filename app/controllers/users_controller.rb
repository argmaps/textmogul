class UsersController < AdminController
  def create
    @user = User.new(adapted_params)

    respond_to do |format|
      if @user.save
        auto_login(@user, true)

        format.json { render :json, status: :ok }
        format.html { redirect_to dashboard_path }
      else
        format.json { render :json => {error: "invalid username-password combination."}, :status => :unprocessable_entity }
        format.html { render 'new', layout: 'outer_admin' }
      end
    end
  end

  def edit
    @user = current_user
    @account = @user.account
  end

  def update
    @user = User.find_by_id!(params[:id])
    @account = @user.account

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
    params.require(:user).permit(:email, :password, :subdomain, :stripe_api_key)
  end
end
