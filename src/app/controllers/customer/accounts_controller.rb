class Customer::AccountsController < Customer::Base
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.assign_attributes(customer_params)
    if @customer.save
      flash.notice = "アカウンティング情報を更新しました"
      redirect_to :customer_account
    else
      render action: "edit"
    end
  end

  private def customer_params
    params.require(:customer).permit(
      :email, :name, :nickname, :introduction
    )
  end
end
