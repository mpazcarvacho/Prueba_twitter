class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :likes
  has_many :retweets
  has_many :liked_tweets, :through => :likes, :source => :tweet
  has_many :retweeted_tweets, :through => :retweets, :source => :tweet
end
