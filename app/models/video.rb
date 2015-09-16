class Video < ActiveRecord::Base
  belongs_to :video_status
  belongs_to :contest

  def save(file)
    
  end
end
