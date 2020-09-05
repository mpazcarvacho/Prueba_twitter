class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :pic_url, presence: true, format: { with: %r{.(gif|jpg|png|jpeg)\Z}i, message: 'must be a URL for GIF, JPG or PNG image.' }
  validates :pic_url, format: URI::regexp(%w[http https])
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :likes
  has_many :retweets
  has_many :liked_tweets, :through => :likes, :source => :tweet
  has_many :retweeted_tweets, :through => :retweets, :source => :tweet
  has_many :friends
  
  

  def to_s
    username
  end

  def follows_user?(current_user, user_id)

    all_relations = Friend.where(user_id: current_user.id, friend_id: user_id)

    if all_relations.any?
      true
    else
      false
    end

  end

  #Método para hacer scope en tweet.rb
  def users_followed
    
    # pluck devuelve array sólo de :friend_id
    array_of_friends = self.friends.pluck(:friend_id)

    #error para leer current_user
    # https://stackoverflow.com/questions/3742785/rails-3-devise-current-user-is-not-accessible-in-a-model#3742981
    #array_of_friends << current_user.id

  end
  

end
