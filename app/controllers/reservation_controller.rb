class ReservationController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: current_user.id).includes(:user).order("created_at DESC")
  end

  def new
    @reservation = Reservation.new
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @user = current_user
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:room_id])
    @user = current_user
    if @reservation.save
      flash[:notice] = "予約が完了しました"
      redirect_to :reservations
    else
      render "room/show"
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(check_in, check_out, total_people, :user_id, :room_id)
  end

end
