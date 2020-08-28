json.extract! tweet, :id, :content, :user_id, :likes, :retweets, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
