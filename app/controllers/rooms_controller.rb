class RoomsController < ApplicationController

  skip_before_action :login_required, only:[:search, :index]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(params.require(:room).permit(:name, :introduction, :charge, :address, :image,))
    if @room.save
      flash[:notice] = "ルームを新規登録しました"
      redirect_to new_booking_path(:room_id => @room.id)
    else
      render "new"
    end
  end

  def search
    @q = Room.ransack(params[:q])
    @rooms = @q.result
  end

end
