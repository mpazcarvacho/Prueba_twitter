class Tweet < ApplicationRecord

  validates :content, presence: true

  belongs_to :user
  has_many :likes
  has_many :retweets
  has_many :users_liked, :through => :likes, :source => :user
  has_many :users_retweeted, :through => :retweets, :source => :user
  

  paginates_per 3

  def liked?(user)
    if self.users_liked.include?(user)
      true
    else
      false
    end
  end

  def destroy_like(user)
    Like.where(user: user, tweet: self).last.destroy
  end

  def like(user)
    Like.create(user: user, tweet: self)
  end

  def retweet_count
    Tweet.where(rt_id: self.id).count
  end
end
