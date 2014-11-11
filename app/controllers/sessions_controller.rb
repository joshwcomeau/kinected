class SessionsController < Devise::SessionsController
  
# GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource), layout: 'narrow_side_page')
  end
end