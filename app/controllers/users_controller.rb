class UsersController < ApplicationController



  def show
  	@user = User.find(params[:id])
    @relationship = Relationship.new
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end

  def chat
    @user = User.find(params[:user_id])
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end

  def match
    @user = current_user
    @users = @user.matchers
    @rooms = Array.new
    @all_messages = Array.new
    for user in @users
      @room_id = message_room_id(current_user, user)
      @messages = Message.recent_in_room(@room_id)
      @rooms.push(@room_id)
      @all_messages.push(@messages)
    end
    @all_messages = @all_messages.flatten
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

  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end

  
  private

    def user_params
    	params.require(:user).permit(:name, :profile_image, :introduce)
    end


end
