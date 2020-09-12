class ApiController < ApplicationController
  #before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:create]

  def authenticate_user!
    user = authenticate(params[:email], params[:password])
  end

  def news
    tweets_50 = Tweet.last(50)

    tweets_hash = tweets_50.map do |tweet|
      {
          :id => tweet.id,
          :content => tweet.content,
          :user_id => if tweet.rt_id?
            # Verifica si hay referencia a retweet
            tweet.retweeted_by_id
          else
            tweet.user_id
          end,
          :like_count => tweet.likes.count,
          :retweets_count => tweet.retweet_count,
          :retwitted_from => if tweet.rt_id?
            # Verifica si hay referencia a retweet
            tweet.user_id
          else
            nil
          end
      }
    end

    render json: tweets_hash.as_json
  end

  def dates_range
    # formato dd-mm-yyyy
    date_from = Date.parse(params[:date_from]).strftime("%d-%m-%Y")
    date_to = Date.parse(params[:date_to]).strftime("%d-%m-%Y")

    tweets_between_range = Tweet.where(created_at: (date_from .. date_to))

    tweets_hash = tweets_between_range.map do |tweet|
      {
          :id => tweet.id,
          :content => tweet.content,
          :user_id => if tweet.rt_id?
            # Verifica si hay referencia a retweet
            tweet.retweeted_by_id
          else
            tweet.user_id
          end,
          :like_count => tweet.likes.count,
          :retweets_count => tweet.retweet_count,
          :retwitted_from => if tweet.rt_id?
            # Verifica si hay referencia a retweet
            tweet.user_id
          else
            nil
          end,
          :created_at => tweet.created_at
      }
    end

    render json: tweets_hash.as_json
  end

  def create_tweet
    user = authenticate(params[:email], params[:password])
    @tweet = Tweet.new(content: tweet_params, user_id: user)
    

    if tweet.save
      render json: {status: 'SUCCESS', message: "Tweet creado", data:tweet}, status: :ok
    else
      render json: {status: 'ERROR', message: "Tweet no pudo ser creado", data:tweet.errors}, status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.permit(:content)
  end


end

# ORIGINAL JSON RETURNS
# {
#   "id": 2,
#   "content": "chao",
#   "user_id": 1,
#   "likes": [
#       {
#           "id": 1,
#           "tweet_id": 2,
#           "user_id": 2,
#           "created_at": "2020-09-06T03:52:56.366Z",
#           "updated_at": "2020-09-06T03:52:56.366Z"
#       }
#   ],
#   "retweets": [],
#   "created_at": "2020-09-06T01:10:49.968Z",
#   "updated_at": "2020-09-06T01:10:49.968Z",
#   "rt_id": null
# },

# Tip: Para lograr esto deberás traer desde la db todos los tweets necesarios; los iterarás para
# crear, por cada uno, un hash con la info solicitada. Los hashes los almacenarás en una variable
# del tipo array que será el elemento a transformar posteriormente en la respuesta json.

# NEEDS TO RETURN
# {
#   id: 1,
#   content: 'este es mi primer tweet',
#   user_id 3,
#   like_count: 10,
#   retweets_count: 20,
#   rewtitted_from: 2
#   },


# https://stackoverflow.com/questions/13017501/ruby-mapping-an-array-to-hashmap
# https://apidock.com/rails/ActiveModel/Serializers/JSON/as_json

# DATES
# https://stackoverflow.com/questions/43378640/rails-datetime-format-dd-mm-yyyy/43378808

# post tweet w authentication
# https://whatraghulearned.wordpress.com/2019/07/15/add-devise_token_auth-to-an-existing-rails-app/
# https://www.youtube.com/watch?v=QojnRc7SS9o min 25:20 create post
# http://perpetuum-mobile.net/tech/devise-as-authentication-solution-for-rails-api/
# https://github.com/gonzalo-bulnes/simple_token_authentication