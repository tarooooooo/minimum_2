class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!,except: [:top, :about]
   

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nickname,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :phone_number,
      :age,
      :icon_image,
      :is_deleted
      ]
      )
  end
end
