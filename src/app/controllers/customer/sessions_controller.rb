class Customer::SessionsController < Customer::Base 
  def new
    if current_customer
      redirect_to :customer_root
    else
      @form = Customer::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Customer::LoginForm.new(params[:customer_login_form])
    if @form.email.present?
      customer = Customer.find_by(email: @form.email)
    end

    if customer
      session[:customer_id] = customer.id
      redirect_to :customer_root 
    else
      render action: "new"
    end
  end

  def destory
    session.delete(:customer_id)
    redirect_to :customer_root
  end
end
