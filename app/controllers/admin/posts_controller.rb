class Admin::PostsController < Admin::ApplicationController
  def index
    @posts = Post.page(params[:page])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_post_path
  end
end
