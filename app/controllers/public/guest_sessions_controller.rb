class Public::GuestSessionsController < Public::ApplicationController
  allow_unauthenticated_access
  def create
    user = User.guest
    start_new_session_for(user)
    redirect_to posts_path, notice: "guestuserでログインしました。"
  end
end 