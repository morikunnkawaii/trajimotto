class Public::RelationshipsController < Public::ApplicationController
  before_action :set_user, only: [:create]

  def create
    Current.user.follow(@user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    Current.user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = User.find(params[:followed_id])
  end

end
