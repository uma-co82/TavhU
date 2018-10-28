class ShopsController < ApplicationController

	def new
		@shop = Shop.new
	end

	def create
		@shop = Shop.new(shop_params)
		@shop.save
		redirect_to root_path
	end

	def index
		@shops = Shop.all
	end

	def show
		@shop = Shop.find(params[:id])
		@user = @shop.favorite_users
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
	private

	 def shop_params
	 	params.require(:shop).permit(:shop_name, :shop_image, :shop_info)
	 end

end
