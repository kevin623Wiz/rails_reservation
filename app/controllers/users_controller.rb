class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:account]

  def account
    @user = current_user
  end

  def profile
    @user = current_user
    @avatar = current_user.avatar
  end

  def show
    @user = current_user
  end

  def profile_edit 
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to users_profile_path(current_user)
    else
      flash[:alert] = "プロフィールを更新できませんでした"
      render users_profile_edit_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :profile, :avatar)
  end

end
