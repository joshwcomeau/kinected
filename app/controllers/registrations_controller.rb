class RegistrationsController < Devise::RegistrationsController
 
  private
 
  def sign_up_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :birthdate, :country, :postal_code, :sex, :self_summary, :height, :income,
      :num_of_kids, :body_type, :smoking, :drinking, :religion, :education, :work_industry, :wants_kids, :relationship_status,
      ethnicity_ids: []
    )
  end

  # def account_update_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  # end
end