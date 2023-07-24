class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # ログインしていないと、ログインページにリダイレクト
  before_action :set_q, only: [:index, :show, :search]

  def index
    @rooms = Room.where(user_id: current_user.id).includes(:user).order("created_at DESC")
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
      if @room.save
        flash[:notice] = "施設を登録しました"
        redirect_to :rooms
      else
        render "new"
      end
  end

  def show
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "施設情報を更新しました"
      redirect_to :rooms
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:alert] = "施設を削除しました"
    redirect_to :rooms
  end

  #検索結果の表示
  def search
    @results = @q.result
  end


  private

  #ransack
  def set_q
    @rooms = Room.includes(:user).order('created_at_DESC')
    @q = Room.ransack(params[:q])
  end

  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :room_image, :user_id)
  end
end
