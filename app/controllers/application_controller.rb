class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configue_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']  # 環境変数を読み込む記述に変更
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitixer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitixer.permit(:sign_up, keys: [:familyname])
    devise_parameter_sanitixer.permit(:sign_up, keys: [:firstname])
    devise_parameter_sanitixer.permit(:sign_up, keys: [:kana_familiyname])
    devise_parameter_sanitixer.permit(:sign_up, keys: [:kana_firstnamename])
    devise_parameter_sanitixer.permit(:sign_up, keys: [:birthday])
  end
end
