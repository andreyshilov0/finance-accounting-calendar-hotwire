class Users::SessionsController < Devise::SessionsController
  respond_to :html, :turbo_stream

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    
    respond_to do |format|
      format.html { respond_with resource, location: after_sign_in_path_for(resource) }
      format.turbo_stream { render turbo_stream: turbo_stream.replace('form_id', partial: 'devise/sessions/successful_login') }
    end
  end
end
