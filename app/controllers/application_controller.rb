class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_user!, except: [:index] # ログインしていないと、ログインページにリダイレクト
    before_action :configure_permitted_parameters, if: :devise_controller?
    # ストロングパラメータの設定

    protected

    def configure_permitted_parameters # deviseで使われているstrong_parameterを上書き
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :iprofile, :avatar])
    end
end
