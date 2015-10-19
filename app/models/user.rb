class User
  require 'securerandom'
  def self.save(user)
    user.merge!(:id => SecureRandom.uuid)
    db = AWS::DynamoDB.new
    table = db.tables['users']
    table.hash_key = {:id => :string}
    table.items.put(user)
  end

  def self.all
    db = AWS::DynamoDB.new
    table = db.tables['users']
    table.hash_key = {:id => :string}
    @users = table.items.select
  end

  def self.find
    db = AWS::DynamoDB.new
    table = db.tables['users']
    table.hash_key = {:id => :string}

  end
end
