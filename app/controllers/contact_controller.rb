class ContactController < SecureController
  layout 'outer_admin'

  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)
    @contact_form.request = request

    if @contact_form.valid?
      @contact_form.deliver
    else
      render :new
    end
  end

private
  def contact_form_params
    params.require(:contact_form).permit(:email, :message)
  end
end
