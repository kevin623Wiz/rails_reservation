class RoomsController < ApplicationController
  def index
    @rooms = Room.where(user_id: current_user.id)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
      if @room.save
        flash[:notice] = "施設を登録しました"
        redirect_to :rooms
      else
        render "new"
      end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :room_image).merge(user_id:current_user.id)
  end
end
