class SubscriptionsController < ApplicationController

  def new
  end

  def create
    email = params[:email]
    # redirect_to new_subscription_path, alert: "No email address was given." if email.nil?

    set_subscription_session(email)

    if session[:subscription]
      if session[:subscription][:status] == "subscribed"
        redirect_to links_path
      else
        redirect_to confirm_subscription_path
      end
    else
      begin
        @mc.lists.subscribe ENV["MAILCHIMP_LIST_ID"], "email" => email
        redirect_to confirm_subscription_path
      rescue Mailchimp::ListAlreadySubscribedError
        redirect_to new_subscription_path, alert: "You're already subscribed..."
      end
    end
  end

  def confirm
    set_subscription_session

    if session[:subscription]
      if session[:subscription][:status] == "subscribed"
        redirect_to links_path
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

      if session[:subscription]
        email = session[:subscription][:email]
      end

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
end
