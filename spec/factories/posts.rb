FactoryBot.define do
  factory :post do
    restaurant_name { 'test_name' }
    food_genre { 1 }
    note { 'test_content' }
    user
  end
end
