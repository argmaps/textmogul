class PasswordResetsController < SecureController
  skip_before_filter :require_login
  layout 'outer_admin'

  def new
    @user = User.new
  end

  # request password reset.
  # you get here when the user entered his email in the reset password form and submitted it.
  def create
    @user = User.find_by_email!(adapted_params[:email])

    # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
    @user.deliver_reset_password_instructions! if @user

    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
  end

  # This is the reset password form.
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated unless @user
  end

  # This action fires when the user has sent the reset password form.
  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated unless @user
    # the next line clears the temporary token and updates the password
    if @user.change_password!(adapted_params[:password])
      auto_login(@user)
      flash[:success] = 'Password was successfully updated.'
      redirect_to(settings_path)
    else
      render :action => "edit"
    end
  end

  private
  def adapted_params
    params.require(:user).permit(:email, :password)
  end
end
