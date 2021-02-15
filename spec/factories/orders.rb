FactoryBot.define do
  factory :order do
    recommend_dish { 'test_dish' }
    reason { 'test_reason' }
    post
  end
end
