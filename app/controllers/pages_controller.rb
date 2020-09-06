class PagesController < ApplicationController
  
  def get_users

    @users = User.all

  end

  def index
    if current_user.nil?
      @tweets = Tweet.order(created_at: :desc).page params[:page]
    else
    
      @tweets = Tweet.tweets_for_me(current_user).order(created_at: :desc).page params[:page]

      # Si hay búsqueda debe devolver búsqueda, si no todos
      if params[:search_tweets] && !params[:search_tweets].empty?
        @tweets = @tweets.where("content like ?", "%#{params[:search_tweets]}%")
      end
    end
    @tweet = Tweet.new

        
        
  end

end
