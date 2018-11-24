class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @relationship = Relationship.new
  end

  def match
    @user = current_user
    @users = @user.matchers
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(@user.id)
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

    def user_params
    	params.require(:user).permit(:name, :profile_image)
    end
end
