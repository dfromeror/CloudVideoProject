class VideoConvertJob < Struct.new(:video_id)
  def perform
    video = Video.find(video_id)
    convert_to_mp4 video.original_path
    #send_email
  end
end