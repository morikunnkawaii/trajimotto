class Public::FavoritesController < Public::ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = Current.user.favorites.new(post_id: post.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = Current.user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end

#redirect_backは直前のページに戻してくれる
#fallback_locationはredirectが失敗した時にいくurl