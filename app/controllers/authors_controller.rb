class AuthorsController < ApplicationController
    before_action :authenticate_author!

  def show
    @author = current_author
    @shops = @author.shops
  end

  def shop_show
    params[:id]
    params[:shop_id]
    @shop = Shop.find(params[:shop_id])
    @reservations = @shop.reservations
  end

  def reservation_update
    params[:shop_id]
    params[:reserve_id]
    @shop = Shop.find(params[:shop_id])
    reservation = Reservation.find(params[:reserve_id])
    reservation.approval = true
    reservation.save
    redirect_to shop_show_path(@shop.id)
  end

  def reservation_delete
    params[:shop_id]
    params[:reserve_id]
    @shop = Shop.find(params[:shop_id])
    reservation = Reservation.find(params[:reserve_id])
    reservation.destroy
    redirect_to shop_show_path(@shop.id)
  end
end
