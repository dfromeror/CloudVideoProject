class HomeController < ApplicationController
	def index
		#@clients = Client.all
	end
	def register
		
	end

	def dynamo
		@user = User.where(:email => 'sergioriosg@gmail.com').all[0]
		x = 1
		@user
	end
end
