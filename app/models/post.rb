class Post < ApplicationRecord
  has_many: orders, dependent: :destroy
  accepts_nested_attributes_for :posts, allow_destroy: true
end
