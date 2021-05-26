class Admin::PostsController < Admin::Base
  def index
    customer = Customer.find(params[:customer_id])
    @posts = Post.where("customer_id = #{customer.id}")
  end

  def show
    @post = Post.find(params[:id])
    @customer = Customer.find_by(id: @post.customer_id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash.notice = "投稿を削除しました"
    redirect_to :admin_customers
  end
end
