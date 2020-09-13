# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "admin@twitty.com", username: "admin", pic_url:"https://www.pinclipart.com/picdir/middle/555-5550136_green-kiwi-bird-icon-clipart.png", admin: true, password: 'adminpass', password_confirmation: 'adminpass')

require 'faker'

10.times do
  User.create(
    email: Faker::Internet.email, 
    username: Faker::Internet.username(specifier: 5..8), 
    pic_url: Faker::Internet.url(host: 'example.com', path: '/foobar.png'), 
    admin: false, 
    password: Faker::Internet.password(min_length: 6)
  )
end

70.times do
  Tweet.create(
    content: Faker::Lorem.question,
    user_id: User.all.sample.id,
  )
end
