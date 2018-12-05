class SeatsController < ApplicationController

  def new
    @seat = Seat.new
  end

  def create
    @seat = Seat.new(seat_params)
    @seat.save
  end

  def destroy
  end

  private

    def seat_params
      params.require(:seat).permit(:time, :count, :fill, :shop_id)
    end
end
