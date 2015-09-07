class User < ActiveRecord::Base
		belongs_to :client
		has_many :contests
end
