class Admin::PostCommentsController < Admin::ApplicationController
  
  def index
    @post_comments = PostComment.page(params[:page])
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    redirect_to admin_dashboards_path, notice: 'コメントを削除しました。'
  end
end
