class Client
	#has_many :users

	def self.all
		db = AWS::DynamoDB.new
		table = db.tables['clients']
		table.hash_key = {:id => :string}
		@clients = table.items.select
	end

	def self.find(id)
		db = AWS::DynamoDB.new
    table = db.tables['clients'].load_schema
    @client = table.items.where(id: id)
	end

end
