class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  

  def show
    
  end

  def index
    # if params[:search].any?
      @users = User.where("username like ?", "%#{params[:search]}%")
    # else
    #   @users = User.all
    # end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :username, :pic_url)
  end

end
