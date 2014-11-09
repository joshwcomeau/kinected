class RegistrationsController < Devise::RegistrationsController
  
  # GET /resource/sign_up
  def new
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    # All of the above is straight-up copied from the Devise::Registrations controller. We're just changing what renders.
    respond_with self.resource, layout: 'onboarding'    
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource, layout: false
    end
  end

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