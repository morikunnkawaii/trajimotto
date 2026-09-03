class GuestSessionsController < ApplicationController
  allow_unauthenticated_access
  def create
    user = User.guest
    start_new_session_for(user)
    redirect_to root_path, notice: "guestuserでログインしました。"
  end
end