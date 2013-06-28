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

  # def set_locale
  #   logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
  #   I18n.locale = params[:locale] || extract_locale_from_accept_language_header
  #   logger.debug "* Locale set to '#{I18n.locale}'"
  # end

  # private
  # def extract_locale_from_accept_language_header
  #   request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  # end
end
