class Public::SearchesController < Public::ApplicationController
  def index
    @query = params[:query]
    @target = params[:target]

    @users = []  #[]で存在はしているんだけど表示はされないようにしている。でないとnilエラーがでるため
    @posts = []
    @message = nil  #nilにする理由はviewでifを使っているから。[]でもいいと思ったが、表示はされなくても[]で配列があると判断されtrueになってしまう為nilになっている
    
    if @query.present? #present?で値があるかないかを判断して値があるときに返す。
      case @target
      when "user"
        @users = User.where("name LIKE ?", "%#{@query}%")
        #モデル.whereで条件に一致した値を全て取得。引数name←カラム LIKE←SQLで部分検索するため。?←セキュリティ攻撃を防ぐ役割。%%を前後に入れることで部分一致でできる。

        @message = "該当するユーザーは見つかりませんでした。" if @users.blank? #blankはpresentの逆で値がないときに返す。emptyよりblankの方がエラーが出ないそう
      when "post"
        @posts = Post.includes(:user).where("title LIKE ?", "%#{@query}%")
        #includesを使うことによって、userを一気に取得して検索を2回で済ませる。ないと検索した時に１０件あったら毎回取得する為重くなる。検索で１回。投稿の取得するたびに取得。１０回。合計１１回これをN+1問題という。includeがあると検索で１回。user取得で１回の計二回になる。

        @message = "該当する投稿は見つかりませんでした。" if @posts.blank?
      end
    end
  end
end
