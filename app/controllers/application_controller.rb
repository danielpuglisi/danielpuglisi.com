require 'mailchimp'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale
  before_action :setup_mcapi

  layout :layout

  # helper_method :current_subscription
  # def current_subscription
  #   session[:subscription]
  # end

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

    def setup_mcapi
      @mc = Mailchimp::API.new(ENV["MAILCHIMP_API_KEY"])
    end

    def authenticate_mc_subscription
      redirect_to new_subscription_path unless session[:subscription] && session[:subscription][:status] == "subscribed"
    end
end
