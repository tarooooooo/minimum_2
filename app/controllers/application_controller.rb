class ApplicationController < ActionController::Base
  include Pundit
   before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
  
  def after_sign_in_path_for(resource)
    
    case resource
    when Admin
      admin_users_path
    when User
      if current_user.category_managements.blank? 
        flash[:success] = "まずは、アイテム制限を設定し、サステナブルへの一歩を踏み出しましょう！（以下のフォームから、アウター、インナー、ボトムスの所持できる数を設定してください）"
        new_category_management_path
      else
        root_path
      end
    end
    
  end

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
      :icon_image,
      :is_deleted
      ]
      )
  end
end
