class Tweet < ApplicationRecord
  # after_save :hashtags no puede ser after_save para que se pase a la db
  before_save :hashtags
  validates :content, presence: true

  belongs_to :user
  has_many :likes, dependent: :delete_all
  has_many :retweets, dependent: :delete_all
  has_many :users_liked, :through => :likes, :source => :user, dependent: :delete_all
  has_many :users_retweeted, :through => :retweets, :source => :user, dependent: :delete_all
  

  paginates_per 50
  
  scope :tweets_for_me, -> (user){ where(user_id: user.users_followed<<user.id)}
  #Añadí user.id (current_user) directamente en users_followed para que el usuario pueda ver sus propios tweets
  
  # Hashtags? https://stackoverflow.com/questions/16308234/how-to-extract-hashtags-and-display-them-groups-by-descending-dates-ruby-on-ra
  # Nota: La forma más sencilla de crear los hashtags es: 1) Convertir el contenido del tweet en
  # un array, donde el espacio entre palabra y palabra puede ser el elemento de separación. LISTO 2)
  # Iterar el array del contenido y revisar si en cada palabra existe un  ; si existe se crea el link
  # con su correspondiente URL y texto, luego el link se retorna al mismo array; en el caso de
  # que no exista el numeral ( ) se retorna al array la palabra completa. 3) Una vez que hemos
  # revisado el array e insertado los links se vuelve a unir el array para convertirlo en un string.
  # 4) Ese string se lo retornamos nuevamente al contenido del tweet.

  def hashtags
    # array con hashtags. añadir each por que o si no hace un sólo split
    @content.split(" ").each do |word| 
      # https://apidock.com/ruby/String/start_with%3F
      if word.start_with?('#')
        # Hashtag, tiene q ser link
        # concatenate root_path to search?? https://stackoverflow.com/questions/8052532/rails-3-1-path-url-to-file-in-public-directory
        word = link_to(word, root_path+"?utf8=✓&search_tweets=#{word}&commit=Buscar+Tweets")
      else

      end
    end
  end

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


