class Order < ApplicationRecord
  belongs_to :post, inverse_of: :orders
end
