class PagesController < ApplicationController
  
  def index
    @tweets = Tweet.order(created_at: :desc).page params[:page]
    @tweet = Tweet.new
  end

end
