Faker::Config.locale = :ja
require 'faker'

20.times do |n|
  name = Faker::JapaneseMedia::StudioGhibli.character
  email = Faker::Internet.email
  password = "password"
  profile = Faker::TvShows::Suits.quote
  profile_image = open("./db/fixtures/icon#{n}.jpeg")
  User.create!(
    name: name,
    email: email,
    password: password,
    profile: profile,
    profile_image: profile_image,
  )
end

30.times do |n|
  restaurant_name = Faker::Restaurant.name
  food_genre = rand(19)
  note = Faker::Restaurant.review
  user_id = rand(1..20)
  Post.create!(
    restaurant_name: restaurant_name,
    food_genre: food_genre,
    note: note,
    user_id: user_id,
  )
end

20.times do |n|
  recommend_dish = Faker::Food.dish
  reason = Faker::Food.description
  dish_image = open("./db/fixtures/img#{n}.jpeg")
  post_id = rand(1..30)
  Order.create!(
    recommend_dish: recommend_dish,
    reason: reason,
    dish_image: dish_image,
    post_id: post_id,
  )
end
