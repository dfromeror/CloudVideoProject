module ApplicationHelper
  def user_logged_email
    session[:user_logged_email]
  end

  def user_logged_name
    session[:user_logged_email]
  end

  def user_logged_id
    session[:user_logged_id]
  end

  def is_user_logged
    session[:is_user_logged]
  end

  def error_message
    session[:error_message]
  end

end
