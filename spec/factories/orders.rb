FactoryBot.define do
  factory :order do
    recommend_dish { 'test_dish' }
    reason { 'test_reason' }
    post
  end
  factory :order2, class: Order do
    recommend_dish { 'test2_dish' }
    reason { 'test2_reason' }
    post
  end
end
