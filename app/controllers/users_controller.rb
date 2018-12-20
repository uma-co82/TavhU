class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:rikuesuto, :request_reject, :request_approval,
                          :quick, :edit, :update,
                          :following, :followers]
  after_action :create_notifications, only: [:request_approval]
  helper_method :message_room_id
  before_action :chat_before, only: [:chat]
  protect_from_forgery :except => [:create_location]



  def show
  	@user = User.find(params[:id])
    @relationship = Relationship.new
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end

  def rikuesuto
    @user = User.find(params[:id])
    @quicks = Quick.where(friend_id: @user.id).joins(:seat).includes(:seat).order("seats.time asc")
  end

  def rikuesuto_show
    @quick = Quick.find(params[:request_id])
  end

  def request_reject
    @user = User.find(params[:user_id])
    @quick = Quick.find(params[:quick_id])
    @quick.destroy
    redirect_to rikuesuto_user_path(@user.id)
  end

  def request_approval
    @user = User.find(params[:user_id])
    @quick = Quick.find(params[:quick_id])
    @seat = @quick.seat
    if @seat.fill == true
      @quick.destroy
      flash[:sign] = "このご予約はすでに埋まっています。"
      redirect_to rikuesuto_user_path(@user.id)
    else 
      @quick.request = true
      @quick.save
      @seat.fill = true
      @seat.save
      redirect_to rikuesuto_user_path(@user.id)
    end
  end

  def favorite_shops
    @shops = current_user.shops.page(params[:page])
  end

  def quick
    @user = User.find(params[:id])
    @quicks = Quick.where(user_id: @user.id).joins(:seat).includes(:seat).order("seats.time asc")
  end

  def quick_show
    @quick = Quick.find(params[:quick_id])
  end


  def chat
    @user = User.find(params[:id])
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end

  def chat_before
    session[:user_id] = current_user.id
  end

  def match
    @user = current_user
    @users = @user.matchers.order(created_at: :desc)
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
    @users = @user.followings.order(created_at: :desc)
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.order(created_at: :desc)
    render 'show_follower'
  end

  def create_location
    @user = current_user
    @user.latitude = params[:latitude].to_f
    @user.longitude = params[:longitude].to_f
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user }
        format.json { render json: @user, js: "alert('Success!')" }
      else
        redirect_to user_path(current_user.id)
      end
    end
  end

  def search_matching_shop
    @user = User.find(params[:id])
    latitude = (@user.latitude + current_user.latitude)/2
    longitude = (@user.longitude + current_user.longitude)/2
    @locations = Shop.within_box(0.310686, latitude, longitude).page(params[:page])
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
    	params.require(:user).permit(:name, :profile_image, :introduce, :phone_number, photos_photos: [])
    end

    def create_notifications
      Notification.create(user_id: @quick.user_id,
      notified_by_id: @user.id,
      notified_type: 'リクエストを承認')
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to shops_path unless @user == current_user
    end


end
