class SubscribersController < UsersController
  layout 'marketing'

  def index
    @subscribers = current_user.subscribers
  end

  def show
  end

  def new
    @subscriber = Subscriber.new
    @subscriber.build_subscription
    @plan = Plan.find_by(stripe_id: 'TMS1')
    @plan_id = @plan.id
  end

  def edit
  end

  def create
    @plan = Plan.find(adapted_params[:subscription_attributes][:plan_id])
    admin = @plan.user
    @subscriber = admin.subscribers.new(adapted_params)

    begin
      Stripe.api_key = admin.stripe_secret_key
      customer = Stripe::Customer.create(
        card: params[:stripeToken],
        plan: @subscriber.subscription.plan.stripe_id,
        email: @subscriber.email
      )
      @subscriber.subscription.stripe_id = customer.id

      if @subscriber.save
        auto_login(@subscriber, true)
        flash[:notice] = 'Welcome!'
        redirect_to settings_path and return
      end
    rescue Stripe::CardError => card_error
      @subscriber.subscription.errors[:card] << card_error
    end
    render 'new', layout: 'outer_admin'
  end

  def update
    if @subscriber.update(subscriber_params)
      redirect_to @subscriber, notice: 'Subscriber was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @subscriber.destroy
    redirect_to subscribers_url, notice: 'Subscriber was successfully destroyed.'
  end

  def adapted_params
    params.require(:subscriber).permit(
      :email, :password, :first_name, :last_name, :phone, :country,
      subscription_attributes: [:card_type, :last_four, :expiration_month, :expiration_year, :plan_id]
    )
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_subscriber
    @subscriber = Subscriber.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def subscriber_params
    params[:subscriber]
  end
end
