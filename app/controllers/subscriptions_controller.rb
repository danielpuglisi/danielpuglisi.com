class SubscriptionsController < ApplicationController

  def new
  end

  def create
    email = params[:email]

    set_subscription_session(email)

    if session[:subscription]
      case session[:subscription][:status]
      when "subscribed"
        redirect_to links_path
      when "pending"
        redirect_to confirm_subscription_path
      when "unsubscribed"
        subscribe(email)
      end
    else
      subscribe(email)
    end
  end

  def confirm
    if session[:subscription]

      set_subscription_session(session[:subscription][:email])

      case session[:subscription][:status]
      when "subscribed"
        redirect_to links_path
      when "unsubscribed"
        redirect_to new_subscription_path
      end
    else
      redirect_to new_subscription_path
    end
  end

  def example
    @issue = Issue.find_by_number(3)
  end

  private
    def set_subscription_session(email=nil)

      if email.present?
        member_info = @mc.lists.member_info ENV["MAILCHIMP_LIST_ID"], [{"email" => email}]

        if member_info["success_count"].to_i > 0
          status = member_info["data"].first["status"]
          session[:subscription] = {email: email, status: status}
        else
          session[:subscription] = nil
        end
      end
    end

    def subscribe(email)
      begin
        @mc.lists.subscribe ENV["MAILCHIMP_LIST_ID"], "email" => email
        redirect_to confirm_subscription_path
      rescue Mailchimp::ListAlreadySubscribedError
        redirect_to links_path, notice: "You're already subscribed..."
      end
    end
end
