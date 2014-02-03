require 'mailchimp'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_locale
  before_action :setup_mcapi

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
      I18n.locale = params[:locale] || extract_locale_from_accept_language_header
    end

    def setup_mcapi
      @mc = Mailchimp::API.new(ENV["MAILCHIMP_API_KEY"])
    end

    def authenticate_mc_subscription
      redirect_to new_subscription_path unless session[:subscription] && session[:subscription][:status] == "subscribed"
    end

    def extract_locale_from_accept_language_header
      browser_locale = request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first).try(:to_sym)
      if I18n.available_locales.include? browser_locale
        browser_locale
      else
        I18n.default_locale
      end
    end
end
