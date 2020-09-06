class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :set_actual_tweet, only: [:likes, :retweets]

  # GET /tweets
  # GET /tweets.json
  def index

    @tweets = Tweet.all
    
    @retweets = Retweet.all
  
  end

  # Método para añadir likes
  def likes
    # Un usuario no puede hacer dos likes sobre el mismo tweet. Por lo tanto, se le debe quitar el
    #like en el caso de que vuelva a hacer click en el botón.
    if user_signed_in?
      if @tweet.liked?(current_user)
        @tweet.destroy_like(current_user)
      else
        @tweet.like(current_user)
      end
      redirect_to root_path
    else
      redirect_to root_path, alert: 'Debes iniciar sesión para dar likes :)'
    end
  end

  def retweets
    # Un usuario puede hacer un retweet haciendo click en la acción rt (retweet) de un tweet, esto
    # hará que ingrese un nuevo tweet con el mismo contenido pero además referenciando al
    # tweet original.
    if user_signed_in?
      tweet_retweeted = Tweet.create(content: @tweet.content, user_id: @tweet.user_id, rt_id: @tweet.id)
      @tweet.retweet(current_user, tweet_retweeted)
      redirect_to root_path
    # Retweet.create(user: current_user, tweet: self)
    else
      redirect_to root_path, alert: 'Debes iniciar sesión para hacer retweets :)'
    end
    
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end



  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def set_actual_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id, :likes, :retweets)
    end

    def set_retweet
      @retweet = Retweet.where(tweet_id: :rt_id)
    end

  
end
