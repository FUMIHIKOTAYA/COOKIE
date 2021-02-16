FactoryBot.define do
  factory :user do
    name { 'user1' }
    email { 'user1@example.com' }
    password { 'password' }
  end
  factory :user2, class: User do
    name { 'user2' }
    email { 'user2@example.com' }
    password { 'password' }
  end
end
