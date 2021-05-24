class Customer::PostsController < Customer::Base
  # skip_before_action :authorize
  # skip_before_action :check_account
  # skip_before_action :check_timeout
  before_action :protect_post, only: [:edit, :update, :destroy]

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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    if post.save
      flash[:notice] = "｢#{post.title}｣の記事を編集しました"
      redirect_to customer_post_path
    else
      redirect_to edit_customer_post_path, flash: {
        post: post,
        alert: "｢#{post.title}｣の記事を編集に失敗しました"
      }
    end
  end

  private 
  
  def post_params
    params.require(:post).permit(:title, :body).merge(customer_id: current_customer.id)
  end

  # 記事作成者と管理者のみ編集、削除可能
  def protect_post
    unless Post.find(params[:id]).customer_id == @current_customer.id || @current_administrator
      redirect_to customer_post_path
      flash.alert = "編集権限がありません"
    end
  end
end