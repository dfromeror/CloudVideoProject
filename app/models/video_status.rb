class VideoStatus
  include Dynamoid::Document
  table :name => :video_statuses, :key => :id, :read_capacity => 1, :write_capacity => 1

  has_many :videos

  field :name
  field :order, :integer
end
