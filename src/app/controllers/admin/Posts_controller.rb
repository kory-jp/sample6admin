class Admin::PostsController < Admin::Base
  def index
    customer = Customer.find(params[:customer_id])
    @posts = Post.where("customer_id = #{customer.id}")
  end
end
