class ApiController < ApplicationController

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

    # render json: Tweet.last(50)
    render json: tweets_hash.as_json
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