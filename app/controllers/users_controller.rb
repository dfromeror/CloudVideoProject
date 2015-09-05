class UsersController < ApplicationController
	def create
		User.create(user_parameters)
		redirect_to root_path
	end

	private

	def user_parameters
		params.require(:user).permit(:first_name, :last_name, :email, :password)
	end
end
