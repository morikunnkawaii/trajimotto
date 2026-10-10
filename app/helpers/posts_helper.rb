module PostsHelper
  def render_with_hashtags(text)
    return "" if text.blank?

    # 文字列中の #タグ名 を検索し、リンクタグへ置換
    html_escape(text).gsub(/[#＃][\w\p{Han}\p{Hiragana}\p{Katakana}_]+/) do |match|
      tag_name = match.delete('#').delete('＃')
      link_to match, posts_path(tag: tag_name), class: 'text-primary hashtag-link'
    end.html_safe
  end
end