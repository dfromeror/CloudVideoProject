require 'rubygems'
require 'streamio-ffmpeg'
require 'securerandom'

module ControllerVideoProcessor
  def convert_to_mp4 path_to_input_file
    movie = FFMPEG::Movie.new("public#{path_to_input_file}")
    options = "-threads 2 -s 320x240 -r 30.00 -threads 1 -pix_fmt yuv420p -g 300 -qmin 3 -b 512k -async 50 -acodec libvo_aacenc -ar 11025 -ac 1 -ab 16k"

    new_video_name = SecureRandom.uuid + ".mp4"

    new_video = movie.transcode(new_video_name, options)

    new_video_path = "/videos/#{new_video_name}"

    File.open("public#{new_video_path}", 'w+') do |f|
      f.write(new_video)
    end


    {:video_name => new_video_name, :video_path => new_video_path}
  end
end