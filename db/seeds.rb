# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "admin@twitty.com", username: "admin", pic_url:"https://www.pinclipart.com/picdir/middle/555-5550136_green-kiwi-bird-icon-clipart.png", admin: true, password: 'adminpass', password_confirmation: 'adminpass')