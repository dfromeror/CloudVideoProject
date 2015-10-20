class Client
  require 'securerandom'

  dynamo_db = AWS::DynamoDB.new
  @@table = dynamo_db.tables[self.name.pluralize.downcase].load_schema

  def self.save(item)
    item.merge!(:id => SecureRandom.uuid)
    @@table.items.put(item)
  end

  def self.all
    @items = @@table.items.select
  end

  def self.find(id)
    @item = @@table.items.where(id: id)
  end

end
