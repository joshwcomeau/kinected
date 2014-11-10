class RegistrationsController < Devise::RegistrationsController
  
  # GET /users/sign_up
  def new
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    # All of the above is straight-up copied from the Devise::Registrations controller. 
    respond_with self.resource, layout: 'onboarding'    
  end

  # POST /users
  def create
    build_resource(sign_up_params)

    if params[:profile_photo]
      resource.profile_photos << ProfilePhoto.new(profile_photo_params)
    end

    # Let's grab the 3 date fields from the params, use it to create a Date, and attach it to resource.
    date_string = "#{params[:birthdate_year]}-#{params[:birthdate_month]}-#{params[:birthdate_day]}"
    date_obj    = Date.strptime(date_string, "%Y-%m-%d")
    resource.birthdate = date_obj

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource), layout: 'onboarding' 
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource), layout: 'onboarding' 
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
    respond_with self.resource, layout: 'onboarding'    
    end
  end

  private
 
  def sign_up_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :birthdate, :country, :postal_code, :sex, :self_summary, :height, :income,
      :num_of_kids, :body_type, :smoking, :drinking, :religion, :education, :work_industry, :wants_kids, :relationship_status,
      :first_name, :last_name, ethnicity_ids: []
    )
  end

  def profile_photo_params
    params.require(:profile_photo).permit(:photo_object)
  end
  # def account_update_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  # end
end