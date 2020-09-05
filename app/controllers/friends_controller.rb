class FriendsController < ApplicationController
  before_action :set_user, only: [:show]
  

  def follow
    Friend.create(user_id: current_user.id, friend_id: params[:user_id])
    redirect_to root_path
  end

  def unfollow
    relation_id= Friend.where(user_id: current_user.id, friend_id: params[:user_id]).last.id
    Friend.destroy(relation_id)
    redirect_to root_path
  end

  def show
    
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id)
  end

end
