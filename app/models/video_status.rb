class VideoStatus

  dynamo_schema do
    attribute :name
    attribute :order, :integer
  end

  has_many :videos
end
