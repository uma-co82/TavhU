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
    @privileges = @shop.privileges
    @privilege = Privilege.new
  end

  def privilege_create
    @privilege = Privilege.new(shop_id: params[:id], content: params[:privilege][:content])
    @privilege.save
    redirect_to author_path(current_author)
  end

  def privilege_destroy
    @privilege = Privilege.find(params[:id])
    @privilege.destroy
    redirect_to author_path(current_author)
  end


end
