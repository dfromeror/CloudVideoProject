class VideoConvertJob < Struct.new(:video_id)
  def perform
    video = Video.find(video_id)
    convert_to_mp4 video
    #send_email
    VideoMailer.video_ready_email(video).deliver
  end
end