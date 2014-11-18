class RegistrationsController < Devise::RegistrationsController
  
  # GET /users/sign_up
  def new
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    # All of the above is straight-up copied from the Devise::Registrations controller. 
    respond_with self.resource, layout: 'narrow_side_page'    
  end

  # POST /users
  def create
    build_resource(sign_up_params)

    # Stop people from toying with the hidden 'role' param
    if role_is_fraudulent
      flash.now[:error] = "Sorry, there was an unexpected problem"
      render :new
      return false
    end

    if params[:profile_photo]
      resource.profile_photos << ProfilePhoto.new(profile_photo_params)
    end

    # Let's update lat/long if Geocoder was able to nab it.
    if request.location.latitude != '0.0' && request.location.longitude != '0.0'
      resource.latitude  = request.location.latitude 
      resource.longitude = request.location.longitude
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
        respond_with resource, location: after_sign_up_path_for(resource), layout: 'narrow_side_page' 
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource), layout: 'narrow_side_page' 
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
    respond_with self.resource, layout: 'narrow_side_page'    
    end
  end

  private
 
  def sign_up_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :birthdate, :country, :postal_code, :sex, :self_summary, :height, :income, :role,
      :num_of_kids, :body_type, :smoking, :drinking, :religion, :education, :work_industry, :wants_kids, :relationship_status,
      :first_name, :last_name, :display_name, ethnicity_ids: []
    )
  end

  def profile_photo_params
    params.require(:profile_photo).permit(:photo_object, :caption)
  end

  def role_is_fraudulent
    params[:user] && params[:user][:role] && params[:user][:role] != 'dater'
  end
  # def account_update_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  # end
end