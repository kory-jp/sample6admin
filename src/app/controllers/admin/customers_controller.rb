class Admin::CustomersController < Admin::Base
  def index
    @customers = Customer.order(:name)
  end

  def show
    customer = Customer.find(params[:id])
    redirect_to [:edit, :admin, customer]
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash.notice = "職員アカウントを新規登録しました。"
      redirect_to :admin_customers
    else
      render action: "new"
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.assign_attributes(customer_params)
    if @customer.save
      flash.notice = "職員アカウントを更新しました。"
      redirect_to :admin_customers
    else
      render action: "edit"
    end
  end

  private def customer_params
    params.require(:customer).permit(
      :email, :name, :password, :nickname, :suspended, :introduction, :image_data
    )
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    flash.notice = "職員アカウントを削除しました"
    redirect_to :admin_customers
  end
end
