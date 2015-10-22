class UsersController < ApplicationController
	def create
		
		User.create(user_parameters)

		redirect_to root_path
	end

	def login
		users = User.where(:email => login_parameters[:email], :password => login_parameters[:password]).all
		if users.count == 1
			session[:user_logged_email] = users[0].email
			session[:user_logged_id] = users[0].id
			session[:user_logged_name] = "#{users[0].first_name} #{users[0].last_name}"
      session[:is_user_logged] = true
      session[:error_message] = nil
		else
			session[:is_user_logged] = false
			session[:error_message] = 'Error en el usuario o clave'
		end
		redirect_to root_path
  end

  def logout
    reset_session
    redirect_to root_path
  end

  private

	def login_parameters
		params.require(:user).permit(:client_id, :email, :password)
	end

	private

	def user_parameters
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end
end
