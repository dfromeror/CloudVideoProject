class VideoMailer < ActionMailer::Base
  default from: "from@example.com"

  def video_ready_email(video)
    @video = video
    mail(to: @video.email, subject: "Hi! your video #{video.name} is ready to watch")
  end
end
