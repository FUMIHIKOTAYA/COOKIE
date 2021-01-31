class Post < ApplicationRecord
  has_many :orders, dependent: :destroy, inverse_of: :post
  accepts_nested_attributes_for :orders, allow_destroy: true

  validates :restaurant_name, presence: true, length: { maximum: 50 }, on: :create
  validates :food_genre, presence: true

  enum food_genre: {
    焼鳥: 0, 焼肉・ホルモン: 1, 蕎麦・うどん: 2, お好み焼き・もんじゃ: 3, 鍋: 4, 丼もの: 5, パスタ・ピザ: 6, ハンバーガー: 7, カレー: 8, ラーメン: 9, 中華料理: 10,
    スペイン料理: 11, タイ料理: 12, 韓国料理: 13, 居酒屋: 14, ワインバー: 15, 和食その他: 16, 洋食その他: 17, カフェ・スイーツ: 18
  }
end
