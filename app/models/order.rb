class Order < ApplicationRecord
  belongs_to :post, inverse_of: :orders

  validates :recommend_dish, length: { maximum: 50 }, presence: true, if: :present_reason_or_dish_image?

  mount_uploader :dish_image, DishImageUploader

  def present_reason_or_dish_image?
    reason.present? || dish_image.present?
  end
end
