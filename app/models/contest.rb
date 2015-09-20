class Contest < ActiveRecord::Base
  belongs_to :user
  has_many :videos
  validates :name, presence: true
  validates :description, presence: true
  validates :media, presence: true
  validates :url, presence: true
  validates :url, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :award_description, presence: true

  self.per_page = 50
end
