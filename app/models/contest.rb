class Contest

  dynamo_schema  do
    attribute :name
    attribute :description
    attribute :media
    attribute :url
    attribute :start_date, :datetime
    attribute :end_date, :datetime
    attribute :award_description, :datetime
  end

  belongs_to :user
  has_many :videos

  self.per_page = 50
end
