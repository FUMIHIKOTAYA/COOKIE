FactoryBot.define do
  factory :post do
    restaurant_name { 'test_name' }
    food_genre { 1 }
    note { 'test_content' }
    user
  end
  factory :post2, class: Post do
    restaurant_name { 'test2_name' }
    food_genre { 18 }
    note { 'test2_content' }
    after(:build) do |post2|
      post2.orders << FactoryBot.build(:order2)
    end
    user
  end
end
