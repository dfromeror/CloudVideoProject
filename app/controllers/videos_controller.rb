class VideosController < ApplicationController
  require 'controller_video_processor'
  include ControllerVideoProcessor

  def convert_videos
    #videos = Video.where(video_status_id: 1)
    video = Video.where(:video_status_id => 1).order(created_at: :desc)[0]
    if video
      convert_to_mp4 video
    end
    # videos.each do |video|
    #   begin
    #     convert_to_mp4 video
    #   rescue Exception => msg
    #     logger.fatal msg
    #   end
    # end
  end
end
