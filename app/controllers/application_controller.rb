class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :null_session

  private
  
  def render_not_found(exception)
    # Optionally, log the exception or perform any other action
    Rails.logger.error exception.message
    render json: { error: "Not found" }, status: :not_found
  end
end
