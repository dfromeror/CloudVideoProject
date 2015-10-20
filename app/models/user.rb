class User
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
    @items = @@table.items.where(id: id)
  end

  def self.login(user, pass)
    item = @@table.items.where(name: user, pass: pass)
    #item2 = @@table.items.where(name: 'xxx', pass: 'xxx')
    db = AWS::DynamoDB::Client::V20120810.new
    item = db.get_item({
                           table_name: 'users',
                           key: {
                               'id' => {
                                   'S' => '015518a6-bab8-4d39-afc2-79eeb897aa9b_'
                               }
                           }
                       })

    # items = db.query({
    #                          :table_name => 'clients',
    #                          :consistent_read => true,
    #                          :select => 'SPECIFIC_ATTRIBUTES',
    #                          :attributes_to_get => ['name'],
    #                          :key_conditions => {
    #                              'name' => {
    #                                  :comparison_operator => 'EQ',
    #                                  :attribute_value_list => [
    #                                      { 's' => 'Sergio' }
    #                                  ],
    #                              }
    #                          }
    #                      })
    x = 1
  end
end
