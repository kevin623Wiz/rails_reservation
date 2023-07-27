class ReservationsController < ApplicationController
  def index
    @user = current_user
    @reservations = Reservation.where(user_id: current_user.id).includes(:user).order("created_at DESC")
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
    @user = current_user
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @user = current_user
    @reservation = Reservation.new(reservation_params) #情報の入ったパラメータを渡す
    if @reservation.save
      flash[:notice] = "予約が完了しました"
      redirect_to :reservations
    else
      render "rooms/show"
    end
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @user = current_user
    if @reservation.check_in == nil
      flash[:alert] = "チェックイン日を入力してください"
      render 'rooms/show' and return
    end
    if @reservation.check_in < Date.today
      flash[:alert] = "過去の日付は選択できません"
      render 'rooms/show' and return
    end
    if @reservation.check_out == nil
      flash[:alert] = "チェックアウト日を入力してください"
      render 'rooms/show' and return
    end
    if @reservation.check_out <= @reservation.check_in
      flash[:alert] = "チェックアウト日はチェックイン日以降の日付を入力してください"
      render 'rooms/show' and return
    end
    if @reservation.total_people == nil
      flash[:alert] = "人数を入力してください"
      render 'rooms/show' and return
    end
    if @reservation.total_people <= 0
      flash[:alert] = "正しい人数を入力してください"
      render 'rooms/show' and return
    end
  end

  def show
    @user = current_user
    @reservation = Reservation.all
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :total_people, :user_id, :room_id)
  end

end
