class BookingsController < ApplicationController

  def index
    @bookings = current_user.bookings
  end

  def new
    @booking = Booking.new
    @room = Room.find(params[:room_id])
    @booking.room_id = params[:room_id]
  end

  def confirm_new
    @booking = current_user.bookings.new(booking_params)
    if @booking.valid?
      @booking.sum_up_total_charge()
    else
      @room = Room.find(params[:room_id])
      render :new
    end
  end

  def create
    @booking = current_user.bookings.build(booking_params)

    if params[:back].present?
      @room = Room.find(@booking.room_id)
      render :new
      return
    end

    if @booking.save
      flash[:notice] = "ルームを予約しました"
      redirect_to booking_path(@booking)
    else
      @room = Room.find(@booking.room_id)
      render :new
    end
  end

  def show
    @booking= Booking.find(params[:id])
  end

  def destroy
    @booking= current_user.bookings.find(params[:id])
    @booking.destroy
    flash[:notice] = "ルームを削除しました"
    redirect_to :bookings
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :termination_date, :number_of_users, :room_id, :total_charge)
  end

end
