class Customer::SessionsController < Customer::Base 
  skip_before_action :authorize
  skip_before_action :check_account
  skip_before_action :check_timeout

  def new
    if current_customer
      redirect_to :customer_root
    else
      @form = Customer::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Customer::LoginForm.new(login_form_params)
    if @form.email.present?
      customer = Customer.find_by(email: @form.email)
    end

    if Customer::Authenticator.new(customer).authenticate(@form.password)
      if customer.suspended?
        customer.events.create!(type: "rejected")
        flash.now.alert = "アカウントが停止されています"
        render action: "new"
      else
        session[:customer_id] = customer.id
        session[:last_access_time] = Time.current
        customer.events.create!(type: "logged_in")
        flash.notice = "ログインしました"
        redirect_to :customer_root 
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません"
      render action: "new"
    end
  end
  
  private def login_form_params
    params.require(:customer_login_form).permit(:email, :password)
  end

  def destroy
    if current_customer
      current_customer.events.create!(type: "logged_out")
    end
    session.delete(:customer_id)
    flash.notice = "ログアウトしました"
    redirect_to :customer_root
  end
end
