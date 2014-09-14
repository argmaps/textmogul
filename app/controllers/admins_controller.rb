class AdminsController < UsersController
  layout 'marketing'

  def new
    @admin = Admin.new
    @admin.build_subscription
    @plan_id = Plan.find_by(stripe_id: 'TM1').id
  end

  def create
    @admin = Admin.new(adapted_params)
    begin
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      customer = Stripe::Customer.create(
        card: params[:stripeToken],
        plan: @admin.subscription.plan.stripe_id,
        email: @admin.email
      )
      @admin.subscription.stripe_id = customer.id

      if @admin.save
        auto_login(@admin, true)
        redirect_to broadcasts_path and return
      end
    rescue Stripe::CardError => card_error
      @admin.subscription.errors[:card] << card_error
    end
    render 'new', layout: 'outer_admin'
  end

  def adapted_params
    params.require(:admin).permit(
      :email, :password, :subdomain, :stripe_secret_key, :stripe_publishable_key, :first_name, :last_name, :country,
      subscription_attributes: [:card_type, :last_four, :expiration_month, :expiration_year, :plan_id]
    )
  end
end
