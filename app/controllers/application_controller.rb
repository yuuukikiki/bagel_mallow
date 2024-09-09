class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_locale
    I18n.locale = :ja # 日本語に設定
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
                                        :name,
                                        :phone_number,
                                        :email,
                                        :password,
                                        :password_confirmation
                                      ])
  end
end
