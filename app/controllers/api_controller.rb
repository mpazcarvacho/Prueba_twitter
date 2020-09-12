class ApiController < ApplicationController

  def news
    render json: Tweet.last(50)
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

# NEEDS TO RETURN
# {
#   id: 1,
#   content: 'este es mi primer tweet',
#   user_id 3,
#   like_count: 10,
#   retweets_count: 20,
#   rewtitted_from: 2
#   },