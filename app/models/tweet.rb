class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :retweets
  has_many :users_liked, :through => :likes, :source => :user
  has_many :users_retweeted, :through => :retweets, :source => :user

  paginates_per 50

end
