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

    if Customer::Authenticator.new(customer).authenticate(@form.password)
      if customer.suspended?
        flash.now.alert = "アカウントが停止されています"
        render action: "new"
      else
        session[:customer_id] = customer.id
        flash.notice = "ログインしました"
        redirect_to :customer_root 
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません"
      render action: "new"
    end
  end

  def destory
    session.delete(:customer_id)
    flash.notice = "ログアウトしました"
    redirect_to :customer_root
  end
end
