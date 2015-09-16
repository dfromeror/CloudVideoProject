class Video < ActiveRecord::Base
  belongs_to :contest
  belongs_to :video_status
end
