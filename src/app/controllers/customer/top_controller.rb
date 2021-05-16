class Customer::TopController < Customer::Base
  skip_before_action :authorize
  skip_before_action :check_account
  skip_before_action :check_timeout

  def index
    render action: "index"
  end
end
