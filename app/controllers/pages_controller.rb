class PagesController < ApplicationController
  
  def get_users

    @users = User.all

  end

  def index
    if current_user.nil?
      @tweets = Tweet.order(created_at: :desc).page params[:page]
    else
    
      @tweets = Tweet.tweets_for_me(current_user).order(created_at: :desc).page params[:page]
    end
    @tweet = Tweet.new
  end

end
