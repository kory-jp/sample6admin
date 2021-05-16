class Customer::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

  private def current_customer
    if session[:customer_id]
      @current_customer ||=
        Customer.find_by(id: session[:customer_id])
    end
  end

  helper_method :current_customer

  private def authorize
    unless current_customer
      flash.alert = "職員としてログインしてください"
      redirect_to :customer_login
    end
  end

  private def check_account
    if current_customer && !current_customer.active?
      session.delete(:customer_id)
      flash.alert = "アカウントが無効になりました"
      redirect_to :customer_root
    end
  end

  TIMEOUT = 60.minutes

  private def check_timeout
    if current_customer
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:customer_id)
        flash.alert = "セッションタイムアウトしました"
        redirect_to :customer_login
      end
    end
  end
end