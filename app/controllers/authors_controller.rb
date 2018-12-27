class AuthorsController < ApplicationController
    before_action :authenticate_author!
    before_action :correct_author, only: [:show, :shop_show]

  def show
    @author = current_author
    @shops = @author.shops
  end

  def shop_show
    params[:id]
    params[:shop_id]
    @shop = Shop.find(params[:shop_id])
    @privileges = @shop.privileges
    @privilege = Privilege.new
    @reviews = @shop.reviews.order(created_at: "DESC")
    @average = @reviews.average(:star)
  end

  def approval_seat    
    @shop = Shop.find(params[:id])
    @seat = Seat.find(params[:seat_id])
    @quicks = @seat.quicks
    for quick in @quicks
      if quick.request == true
        @quick = quick
      end
    end
    @user = User.find(@quick.user_id)
  end

  def privilege_create
    @privilege = Privilege.new(shop_id: params[:id], content: params[:privilege][:content])
    if @privilege.save
      redirect_to author_path(current_author)
    else
      @shop = Shop.find(params[:id])
      @privileges = @shop.privileges
      flash[:sign] = "特典の登録は5件まで可能です。"
      render 'shop_show'
    end
  end

  def privilege_destroy
    @privilege = Privilege.find(params[:privilege_id])
    if Seat.where(privilege_id: params[:privilege_id]).present?
      flash[:sign] = "特典が利用された登録があります。確認してください。"
      redirect_to shop_show_path(id: current_author.id, shop_id: params[:shop_id])
    elsif Seat.where(privilege_secound_id: params[:privilege_id]).present?
      flash[:sign] = "特典が利用された登録があります。確認してください。"
      redirect_to shop_show_path(id: current_author.id, shop_id: params[:shop_id])
    elsif Seat.where(privilege_third_id: params[:privilege_id]).present?
      flash[:sign] = "特典が利用された登録があります。確認してください。"
      redirect_to shop_show_path(id: current_author.id, shop_id: params[:shop_id])
    else
      @privilege.destroy
      redirect_to author_path(current_author)
    end
  end

  private 
  
    def correct_author
      @author = Author.find(params[:id])
      redirect_to new_author_session_path unless @author == current_author
    end

end
