class SeatsController < ApplicationController
  after_action :create_notifications, only: [:seat_reserve_create]
  before_action :authenticate_author!, only: [:create, :destroy, :index]
  # before_action :correct_author, only: [:index]
  before_action :authenticate_user!, only: [:index_user, :seat_like, :seat_reserve, :seat_reserve_create,
                                :quick_delete]


  def create
    @shop = Shop.find(params[:id])
    @seat = Seat.new(seat_params)
    @seat.shop_id = @shop.id
    if @seat.save
      redirect_to author_path(current_author.id)
    else
      @shop = Shop.find(params[:id])
      @seats = @shop.seats
      @seat_times = Array.new
      @seats.each do |seat|
      seat_time = seat.time.to_date
      @seat_times.push(seat_time)
      end
      @seat_times = @seat_times.uniq
      render "index"
    end
  end

  def destroy
    @seat = Seat.find(params[:id])
    @seat.destroy
    redirect_to author_path(current_author.id)
  end

  def index
    @shop = Shop.find(params[:id])
    @seat = Seat.new
    @seats = @shop.seats.order(time: "ASC")
    @seat_times = Array.new
    @seats.each do |seat|
      seat_time = seat.time.to_date
      @seat_times.push(seat_time)
    end
    @seat_times = @seat_times.uniq
  end

  def index_user
    @shop = Shop.find(params[:id])
    @seats = @shop.seats.fill.ok.order(time: "ASC")
    @seat_time = Array.new
    @seats.each do |seat|
      seat_t = seat.time.to_date
      @seat_time.push(seat_t)
    end
    @seat_time = @seat_time.uniq
  end

  def fav
    seat = Seat.find(params[:id])
    if seat.liked_by?(current_user)
      fav = current_user.likes.find_by(seat_id: seat.id)
      fav.destroy
      render json: seat.id
    else
      fav = current_user.likes.new(seat_id: seat.id)
      fav.save
      render json: seat.id
    end
  end

  def seat_like
    seat = Seat.find(params[:id])
    @users = seat.like_users.shuffle
  end

  def seat_reserve
    seat = Seat.find(params[:seat_id])
    @quick = Quick.new
  end

  def seat_reserve_create
    seat = Seat.find(params[:seat_id])
    shop = seat.shop
    @quick = Quick.new(user_id: current_user.id, friend_id: params[:quick][:friend_id], seat_id: seat.id)
    if seat.fill == true
      flash[:sign] = "もう埋まっています。"
      render 'seat_reserve'
    elsif @quick.save
      redirect_to quick_user_path(current_user.id)
    else 
      seat = Seat.find(params[:seat_id])
      render 'seat_reserve'
    end
  end

  def quick_delete
    @quick = Quick.find(params[:quick_id])
    @quick.destroy
    redirect_to quick_user_url(current_user.id)
  end

	def imasugu 
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
    @locations = Shop.within_box(0.310686, latitude, longitude)
		@seats = []
		for shop in @locations
			@seats.push(shop.seats.where(time: Time.zone.now..Time.zone.now.since(2.hour)))
		end
		@seats = @seats.flatten
	end

  private

    def seat_params
      params.require(:seat).permit(:time, :count, :fill, :shop_id, :privilege_id, :privilege_secound_id, :privilege_third_id)
    end

    def create_notifications
        Notification.create(user_id: @quick.friend_id,
        notified_by_id: current_user.id,
        notified_type: 'リクエスト')
    end

    # def correct_author
    #   @author = Author.find(params[:id])
    #   redirect_to new_author_session_path unless @author = current_author
    # end
    
end
