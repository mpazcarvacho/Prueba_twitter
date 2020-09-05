class PagesController < ApplicationController
  
  
  def index

    @tweets = Tweet.tweets_for_me(current_user).order(created_at: :desc).page params[:page]

    # @tweets = Tweet.order(created_at: :desc).page params[:page]
    
    @tweet = Tweet.new
  end

end
