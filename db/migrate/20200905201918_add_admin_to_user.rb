class AddAdminToUser < ActiveRecord::Migration[5.2]
  def change
    #HARDCODED ADMIN ACCOUNT
    User.create(email: "admin@twitty.com", username: "admin", pic_url:"https://www.pinclipart.com/picdir/middle/555-5550136_green-kiwi-bird-icon-clipart.png", 
      admin: true, password: 'adminpass', password_confirmation: 'adminpass')
  end

