require 'rubygems'
require 'streamio-ffmpeg'
require 'securerandom'

module ControllerVideoProcessor
  def convert_to_mp4 video
    contest = Contest.find(video.contest_id)
    movie = FFMPEG::Movie.new("public#{video.original_path}")
    options = "-threads 2 -s 320x240 -r 30.00 -threads 1 -pix_fmt yuv420p -g 300 -qmin 3 -b 512k -async 50 -acodec libvo_aacenc -ar 11025 -ac 1 -ab 16k"
    #options = "-acodec aac -vcodec libx264 -profile:v high -strict -2"
    contest_folder = Rails.root.join("public", "videos", "#{contest.name.squish.downcase.tr(" ", "_")}")
    contest_converted_folder = Rails.root.join("public", "videos", "#{contest.name.to_s.underscore}", "converted")
    Dir.mkdir(contest_folder) unless File.exist?(contest_folder) #si no existe el folder del concurso se crea
    Dir.mkdir(contest_converted_folder) unless File.exist?(contest_converted_folder) #si no se ha convertido ningun video para el concurso se crea el folder de videos convertidos
    base_name = File.basename(video.original_path, ".*") + ".mp4"
    converted_path = Rails.root.join("public", "videos", "#{contest.name.squish.downcase.tr(" ", "_")}", "converted", base_name)
    #converted_video = movie.transcode(base_name, options)
    movie.transcode(converted_path, options)
    # File.open(converted_path, 'w+') do |f|
    #   f.write(converted_video)
    # end

    #Actualizar datos de converion del video
    video.converted_path = converted_path.to_s[Rails.root.join("public").to_s.size..-1]
    video.converted_name = base_name
    video.conversion_date = Date.current
    video.video_status_id = 2
    video.save

    video
  end
end