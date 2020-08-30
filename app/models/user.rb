class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :pic_url, presence: true, format: { with: %r{.(gif|jpg|png)\Z}i, message: 'must be a URL for GIF, JPG or PNG image.' }
  validates :pic_url, format: URI::regexp(%w[http https])
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :likes
  has_many :retweets
  has_many :liked_tweets, :through => :likes, :source => :tweet
  has_many :retweeted_tweets, :through => :retweets, :source => :tweet

  #IDEAS PARA VALIDAR PIC_URL https://stackoverflow.com/posts/11478776/revisions
  # https://edgeguides.rubyonrails.org/active_record_validations.html#validates-with
#   def validate(record)
#     if record.first_name == "Evil"
#       record.errors.add :base, "This person is evil"
#     end
#   end


#   allowed_extensions = %w[.jpg .jpeg .png]
# if my_str.start_with?('http://') &&
#    allowed_extensions.any?{ |ext| my_str.end_with?(ext) }

  def to_s
    username
  end

end
