class TopsController < ApplicationController
  def index
    @user = current_user
    @q = Room.ransack(params[:q])
    @results = @q.result(distinct: true)
  end
end
