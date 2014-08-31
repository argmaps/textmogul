class SessionsController < SecureController
  layout 'outer_admin'

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      if @user = login(adapted_params[:email].downcase, adapted_params[:password], remember_me=true)
        format.json { render json: @user, :status => :ok }
        format.html { redirect_back_or_to(dashboard_path) }
      else
        error_msg = "Login failed. Please try again."
        format.json { render :json => {error: error_msg}, :status => :unprocessable_entity }
        format.html { flash.now['danger'] = error_msg; render :action => "new" }
      end
    end
  end

  def destroy
    logout
    redirect_to sign_in_path
  end

  private
  def adapted_params
    params.require(:user).permit(:email, :password)
  end
end
