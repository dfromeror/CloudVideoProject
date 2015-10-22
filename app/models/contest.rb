class Contest
  include Dynamoid::Document
  table :name => :contests, :key => :id, :read_capacity => 1, :write_capacity => 1

  belongs_to :user
  has_many :videos

  field :user_id
  field :name
  field :description
  field :media
  field :url
  field :start_date, :datetime
  field :end_date, :datetime
  field :award_description


  #self.per_page = 50
end
