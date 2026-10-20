class Admin::DashboardsController < Admin::ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @post_comments = @user.post_comments.page(params[:page])
  end
end
