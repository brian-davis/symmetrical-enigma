class SessionsController < Devise::SessionsController
  after_action :verify_recognized_browser, only: :create

  def verify_recognized_browser
    if unrecognized_browser?(current_user)
      # Alternative to current_user.send_reset_password_instructions
      #   rails g devise:views
      #   app/views/devise/mailer/reset_password_instructions.html.erb

      mailer_options = {
        user: current_user,
        password_reset_url: unrecognized_browser_password_reset_url(current_user)
      }
      UserMailer.with(mailer_options).unrecognized_login.deliver_later
    end
  end

  private

  def unrecognized_browser?(user)
    (user.last_sign_in_ip != user.current_sign_in_ip) ||
    (user.last_sign_in_user_agent != user.current_sign_in_user_agent)
  end

  # see :set_reset_password_token @ gems/devise-4.6.2/lib/devise/models/recoverable.rb
  def unrecognized_browser_password_reset_url(user)
    raw, enc = Devise.token_generator.generate(User, :reset_password_token)
    user.reset_password_token = enc
    user.reset_password_sent_at = Time.now.utc
    user.save(validate: false)

    edit_password_url(user, reset_password_token: raw)
  end
end
