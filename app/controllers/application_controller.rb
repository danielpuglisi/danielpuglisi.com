class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  layout :layout

  private
  def layout
    if is_a?(Devise::SessionsController)
      "login"
    else
      "application"
    end
  end

  def set_locale
    available = %w{en de}
    I18n.locale = params[:locale] || request.preferred_language_from(available)
  end
end
