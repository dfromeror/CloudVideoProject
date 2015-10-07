namespace :convert_video_task do
  desc "Convert all videos without convert"
  task convert_oldest_video: :environment do
    oldest_video = Video.where(:video_status_id => 1).order(created_at: :desc)[0]
    convert_to_mp4 oldest_video
  end

  def convert_to_mp4 video


    #creating a temporal folder
    local_video_path = Rails.root.join("public", "tmp", "#{video.class.to_s.underscore}", "#{video.id}")
    FileUtils.mkdir_p local_video_path unless File.exist?(local_video_path)
    #getting video name
    file_name = File.basename(video.video.url(:default, timestamp: false))
    #downloading the file locally
    full_path_file = Rails.root.join(local_video_path, file_name)
    open(full_path_file, 'wb') do |file|
      file << open(video.video.url(:default, timestamp: false)).read
    end

    movie = FFMPEG::Movie.new(full_path_file)
    options = "-threads 2 -s 320x240 -r 30.00 -threads 1 -pix_fmt yuv420p -g 300 -qmin 3 -b 512k -async 50 -acodec libvo_aacenc -ar 11025 -ac 1 -ab 16k"
    new_video_file_path = Rails.root.join("public", "tmp", "#{video.class.to_s.underscore}", "#{video.id}")
    new_video_file_name = File.basename(video.video.url, ".*") + ".mp4"
    full_new_video_file_name = Rails.root.join(new_video_file_path, new_video_file_name)
    movie.transcode(full_new_video_file_name, options)
    attach_name = "video_converted"
    attach = Paperclip::Attachment.new(attach_name, video, video.class.attachment_definitions[attach_name.to_sym])
    file = File.open(full_new_video_file_name)
    attach.assign file
    attach.save
    file.close
    video.video_status_id = 2
    video.save

    FileUtils.rm_rf(full_path_file)
    FileUtils.rm_rf(full_new_video_file_name)

    VideoMailer.video_ready_email(video).deliver

    video
  end
end
