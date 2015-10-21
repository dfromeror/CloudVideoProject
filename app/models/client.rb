class Client
	include Dynamoid::Document
  table :name => :clients, :key => :id, :read_capacity => 1, :write_capacity => 1

	field :name
	field :email
	field :layout
	field :logo

end
