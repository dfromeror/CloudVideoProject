class DynamoBase

  @@table = nill

  def self.all
    @@table.items.select
  end
end