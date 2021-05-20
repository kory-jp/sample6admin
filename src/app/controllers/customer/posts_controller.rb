class Customer::PostsController < Customer::Base
  # skip_before_action :authorize
  # skip_before_action :check_account
  # skip_before_action :check_timeout

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash.notice ="新規投稿が完了しました"
      redirect_to :customer_posts
    else
      flash.alert = "投稿に失敗しました"
      render action: "customer_new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private def post_params
    params.require(:post).permit(:title, :body).merge(customer_id: current_customer.id)
  end
end