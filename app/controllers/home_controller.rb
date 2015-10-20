class HomeController < ApplicationController
	def index
		@clients = Client.order(name: :asc).all
	end
	def register
		
	end

	def dynamo
		# respond_to do |format|
		# 	format.html { render :layout => false } # your-action.html.erb
		# end

		#User.save({:name => 'Sergio', :email => 'sergioriosg@gmail.com', :pass => '12345'})
		#cName = Client.class.name.pluralize
		#@users = User.all
		#@clients = Client.all
		#@client = Client.find('32d264d8-229f-4305-9352-93c2d6bcc7bf')
		#user = User.save({:name => 'Sergio Rios', :client => @client.to_s})
		#x = 1
		# dbo = AWS::DynamoDB.new
		# table = dbo.tables['clients']
		# table.hash_key = { :id => :number }
		# @item = table.items.create( 'id' => '1', 'name' => 'Sergio', 'email' => 'sergioriosg@gmail.com', 'birth_date' => '1984-12-03')

		User.login('sergio', '123')
	end
end
