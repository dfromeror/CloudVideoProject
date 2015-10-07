class VideoMailer < ActionMailer::Base
  default from: "robot@smarttools.com"

  def video_ready_email(video)
    @video = video
    mail(to: @video.email, subject: "Hi! your video #{video.video_file_name} is ready to watch")
  end
end
