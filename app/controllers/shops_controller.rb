class ShopsController < ApplicationController
	before_action :authenticate_author!, only:[:new, :create, :destroy]

	def new
		@shop = Shop.new
	end

	def create
		@shop = Shop.new(shop_params)
		@shop.author_id = current_author.id
		@shop.genre_id = params[:shop][:genre_id]
		@shop.station_id = params[:shop][:station_id]
		@shop.save!
		if @shop.save
			redirect_to author_path(current_author.id)
		else
			@shop = Shop.new
			render "new"
		end
	end

	def index
		@shops = Shop.page(params[:page])
		@jp_prefectures = JpPrefecture::Prefecture.all
		@tohokus = Array.new
		@kantous = Array.new
		@tyubus = Array.new
		@kansais = Array.new
		@tyugokus = Array.new
		@sikokus = Array.new
		@kyusyus = Array.new
		for prefecture in @jp_prefectures
			if prefecture.area == "北海道"
				@tohokus.push(prefecture)
			elsif prefecture.area == "東北"
				@tohokus.push(prefecture)
			elsif prefecture.area == "関東"
				@kantous.push(prefecture)
			elsif prefecture.area == "中部"
				@tyubus.push(prefecture)
			elsif prefecture.area == "関西"
				@kansais.push(prefecture)
			elsif prefecture.area == "中国"
				@tyugokus.push(prefecture)
			elsif prefecture.area == "四国"
				@sikokus.push(prefecture)
			else
				@kyusyus.push(prefecture)
			end
		end
		@genres = Genre.all
	end

	def index_prefecture
		@shops = Shop.where(prefecture_code: params[:id]).page(params[:page])
	end

	def index_genre
		@shops = Shop.where(genre_id: params[:id]).page(params[:page])
	end
	def show
		@shop = Shop.find(params[:id])
		@user = @shop.favorite_users
	end

	def destroy
		@shop = Shop.find(params[:id])
		@shop.destroy
		render json: @shop.id
		redirect_to author_path(current_author.id)
	end

	def reserve
		@shop = Shop.find(params[:id])
		@reservation = Reservation.new
	end

	def reserve_create
		@shop = Shop.find(params[:id])
		@reservation = Reservation.new(user_id: current_user.id, shop_id: @shop.id, start_time: DateTime.new(params[:reservation]["start_time(1i)"].to_i, params[:reservation]["start_time(2i)"].to_i, params[:reservation]["start_time(3i)"].to_i, params[:reservation]["start_time(4i)"].to_i, params[:reservation]["start_time(5i)"].to_i), member_count: params[:reservation][:member_count])
		@reservation.save
		redirect_to shops_path
	end

	def fav
	 shop = Shop.find(params[:id])
	 if shop.favorite_by?(current_user)
	   fav = current_user.favorites.find_by(shop_id: shop.id)
	   fav.destroy
	   render json: shop.id
	 else
	   fav = current_user.favorites.new(shop_id: shop.id)
	   fav.save
	   render json: shop.id
	 end
	end

	def shop_fav
		@shop = Shop.find(params[:id])
		@user = @shop.favorite_users.shuffle
	end

	private

	 def shop_params
	 	params.require(:shop).permit(:shop_name, :shop_image, :shop_info, :genre_id, :station_id, :postcode, :prefecture_code, :address, :address_street, :address_building)
	 end

end
