class Post < ApplicationRecord
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  belongs_to :user
  has_many :favorites, dependent: :destroy

  acts_as_taggable_on :tags
  before_save :extract_hashtags

  scope :min_favorites, ->(count) {where("favorites_count >= ?", count.to_i) if count.present? && count.to_i > 0}

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  private
  def extract_hashtags
    # 3つのフィールドを結合（nilの場合は空文字にする）
    text = "#{title} #{body} #{address}"
    return if text.blank?

    # 結合した文字列からハッシュタグを自動抽出
    hashtags = text.scan(/[#＃][\w\p{Han}\p{Hiragana}\p{Katakana}_]+/)

    self.tag_list = hashtags.map { |tag| tag.delete('#').delete('＃') }.uniq
  end
end
