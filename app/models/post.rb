class Post < ApplicationRecord
  has_many :orders, dependent: :destroy, inverse_of: :post
  accepts_nested_attributes_for :posts, allow_destroy: true

  validates :restaurant_name, presence: true, length: { maximum: 50 }
  validates :food_genre, presence: true
end
