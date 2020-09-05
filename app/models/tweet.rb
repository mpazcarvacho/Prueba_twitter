class Tweet < ApplicationRecord

  validates :content, presence: true

  belongs_to :user
  has_many :likes, dependent: :delete_all
  has_many :retweets, dependent: :delete_all
  has_many :users_liked, :through => :likes, :source => :user, dependent: :delete_all
  has_many :users_retweeted, :through => :retweets, :source => :user, dependent: :delete_all
  

  paginates_per 50

  scope :tweets_for_me, -> (user){ where(user_id: user.users_followed)}

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

  def retweeted?
    if rt_id
      true
    else
      false
    end
  end

  def retweet(user, tweet_retweeted)
    Retweet.create(user_id: user.id, tweet_id: tweet_retweeted.id)
  end

  def find_rw
    Tweet.find(self.rt_id)
  end

  def retweeted_user_pic
    user_id = Retweet.where(tweet_id: self.id).first.user_id
    pic = User.find(user_id).pic_url
    
  end

  def retweeted_by
    
    user_id = Retweet.where(tweet_id: self.id).first.user_id
    User.find(user_id).username
  end
end


