class Order < ApplicationRecord
  belongs_to :post, inverse_of: :orders

  validates :recommend_dish, length: { maximum: 50 }

  mount_uploader :dish_image, DishImageUploader
end
