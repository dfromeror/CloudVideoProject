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

		#User.save({:name => 'Sergio', :email => 'sergioriosg@gmail.com', :pass => '123'})
		@users = User.all
		@client = Client.find('32d264d8-229f-4305-9352-93c2d6bcc7bf')
		x = 1
		# dbo = AWS::DynamoDB.new
		# table = dbo.tables['clients']
		# table.hash_key = { :id => :number }
		# @item = table.items.create( 'id' => '1', 'name' => 'Sergio', 'email' => 'sergioriosg@gmail.com', 'birth_date' => '1984-12-03')
	end
end
