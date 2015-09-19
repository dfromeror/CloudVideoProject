class HomeController < ApplicationController
	def index
		@clients = Client.order(name: :asc).all
	end
	def register
		
	end
end
