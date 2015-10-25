require 'rubygems'
require 'streamio-ffmpeg'
require 'securerandom'
require 'fileutils'
require 'pathname'

module ControllerVideoProcessor
  def convert_to_mp4 video


    #creating a temporal folder
    local_video_path = Rails.root.join("public", "tmp", "#{video.class.to_s.underscore}", "#{video.id}")
    FileUtils.mkdir_p local_video_path unless File.exist?(local_video_path)
    #getting video name
    file_name = File.basename(video.original_file_path)
    #downloading the file locally
    full_path_file = Rails.root.join(local_video_path, file_name)

    S3Service.download(video.original_key, full_path_file)

    movie = FFMPEG::Movie.new(full_path_file)
    options = "-threads 2 -s 320x240 -r 30.00 -threads 1 -pix_fmt yuv420p -g 300 -qmin 3 -b 512k -async 50 -acodec libvo_aacenc -ar 11025 -ac 1 -ab 16k"
    new_video_file_path = Rails.root.join("public", "tmp", "#{video.class.to_s.underscore}", "#{video.id}")
    new_video_file_name = File.basename(video.original_file_name, ".*") + ".mp4"
    full_new_video_file_name = Rails.root.join(new_video_file_path, new_video_file_name)
    movie.transcode(full_new_video_file_name, options)

    key = File.join("converted", "#{video.contest_id}", "#{DateTime.now.to_i}", "#{new_video_file_name}")

    s3_file = S3Service.put(key, File.open(full_new_video_file_name))

    video_status = VideoStatus.where(:order => 2).all[0]

    video.converted_file_name = new_video_file_name
    video.converted_file_path = s3_file.public_url.to_s
    video.video_status_id = video_status.id
    video.update

    FileUtils.rm_rf(full_path_file)
    FileUtils.rm_rf(full_new_video_file_name)

    VideoMailer.video_ready_email(video).deliver

    video
  end
end