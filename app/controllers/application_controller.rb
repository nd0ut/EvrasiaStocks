class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  private
  def render_404
    render :template => 'error_pages/404', :layout => true, :status => :not_found
  end
end
