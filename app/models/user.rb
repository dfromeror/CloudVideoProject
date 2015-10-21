class User
  include Dynamoid::Document
  table :name => :users, :key => :id, :read_capacity => 1, :write_capacity => 1

  field :first_name
  field :last_name
  field :email
  field :password
  field :client_id, :integer
end
