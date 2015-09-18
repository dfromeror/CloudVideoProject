class VideosController < ApplicationController
  require 'controller_video_processor'
  include ControllerVideoProcessor

  def convert_videos
    videos = Video.where(conversion_date: nil)

    videos.each do |video|
      begin
        new_video = convert_to_mp4 video.original_path
        video.converted_path = new_video[:video_path]
        video.conversion_date = Date.current
        video.converted_name = new_video[:video_name]
        video.save
      rescue Exception => msg
        logger.fatal msg
      end
    end
  end
end
