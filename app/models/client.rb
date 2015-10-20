class Client
	#has_many :users
  dynamo_db = AWS::DynamoDB.new
  @@table = dynamo_db.tables[self.name.pluralize.downcase].load_schema

	def self.all
		@clients = @@table.items.select
	end

	def self.find(id)
    @client = table.items.where(id: id)
	end

end
