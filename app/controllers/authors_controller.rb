class AuthorsController < ApplicationController
    before_action :authenticate_author!

  def show
    @author = current_author
    @shops = @author.shops
  end

  def shop_show
    @shop = Shop.find(params[:id])
    @reservations = @shop.reservations
  end

  def reservation_update
    @shop = Shop.find(params[:shop_id])
    reservation = Reservation.find(params[:reserve_id])
    reservation.approval = true
    reservation.save
    redirect_to shop_show_path(@shop.id)
  end

  def reservation_delete
    @shop = Shop.find(params[:shop_id])
    reservation = Reservation.find(params[:reserve_id])
    reservation.destroy
    redirect_to shop_show_path(@shop.id)
  end
end
