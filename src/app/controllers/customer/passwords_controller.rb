class Customer::PasswordsController < Customer::Base
  def show
    redirect_to :edit_customer_password
  end

  def edit
    @change_password_form = Customer::ChangePasswordForm.new(object: current_customer)
  end

  def update
    @change_password_form = Customer::ChangePasswordForm.new(customer_params)
    @change_password_form.object = current_customer
    if @change_password_form.save
      flash.notice = "パスワードを変更しました"
      redirect_to :customer_account
    else
      flash.now.alert = "入力に誤りがあります"
      render action: "edit"
    end
  end

  private def customer_params
    params.require(:customer_change_password_form).permit(:current_password, :new_password, :new_password_confirmation)
  end
end
