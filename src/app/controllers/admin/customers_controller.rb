class Admin::CustomersController < Admin::Base
  def index
    @customers = Customer.order(:name)
  end
end
