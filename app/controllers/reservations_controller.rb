class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: current_user.id).includes(:user).order("created_at DESC")
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params) #情報の入ったパラメータを渡す
    @room = Room.find(params[:room_id])
    @user = current_user
    if @reservation.save
      flash[:notice] = "予約が完了しました"
      redirect_to :reservations
    else
      render "room/show"
    end
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :total_people, :user_id, :room_id)
  end

end
