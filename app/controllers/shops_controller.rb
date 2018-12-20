class ShopsController < ApplicationController
	before_action :authenticate_author!, only:[:new, :create, :destroy, :edit]
	before_action :authenticate_user!, only: [:index, :index_genre, :index_prefecture,
										:search_station, :search_station_genre, :search_location, :show,
										:shop_fav]

	def new
		@shop = Shop.new
		@shop.images.build
	end

	def create
		@shop = Shop.new(shop_params)
		@shop.address = @shop.address_city
		@shop.address = @shop.address.gsub(/\d+/, "").gsub(/\-+/, "")
		@shop.author_id = current_author.id
		@shop.genre_id = params[:shop][:genre_id]
		@shop.station_id = params[:shop][:station_id]
		@shop.save
		if @shop.save
			redirect_to author_path(current_author.id)
		else
			render "new"
		end
	end

	def edit
		@shop = Shop.find(params[:id])
	end

	def update
		@shop = Shop.find(params[:id])
		@shop.update(shop_params)
		if @shop.save
			redirect_to author_url(current_author)
		else
			render 'edit'
		end
	end

	def index
		@shops = Shop.find(Favorite.group(:shop_id).order('count(shop_id) desc').pluck(:shop_id))
		@shops = Kaminari.paginate_array(@shops).page(params[:page])
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

	def search_station
		@shops = Shop.search(params[:search]).page(params[:page])
	end

	def search_station_genre
		@shops = Shop.search(params[:search]).where(genre_id:params[:id]).page(params[:page])
	end

	def search_location
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
		@locations = Shop.within_box(0.310686, latitude, longitude).page(params[:page])
	end

	def show
		@shop = Shop.find(params[:id])
		@review = Review.new
		@reviews = Review.where(shop_id: @shop.id).limit(5)
		@average = @reviews.average(:star)
	end

	def review_create
		@review = Review.new(user_id: current_user.id, shop_id: params[:id], content: params[:review][:content], star: params[:review][:star])
		if @review.save
			redirect_to shop_url(params[:id])
		else
			@shop = Shop.find(params[:id])
			render 'show'
		end
	end

	def destroy
		@shop = Shop.find(params[:id])
		@shop.destroy
		redirect_to author_path(current_author.id)
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
	 	params.require(:shop).permit(:shop_name, :shop_image, :shop_info, :genre_id, :station_id, :postcode, :prefecture_code, :address_city, :address_street, :address_building, images_images: [])
	 end

end
