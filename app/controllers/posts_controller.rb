class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = Current.user.id
    @post.save
    redirect_to posts_path, notice:"投稿が完了しました！"
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end
end
