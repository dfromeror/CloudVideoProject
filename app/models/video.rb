class Video < ActiveRecord::Base
  belongs_to :contest
  has_one :video_status

  def self.upload(file)
    name = file[:video].original_filename
    videoPost = Video.new
    videoPost.original_name = name
    videoPost.original_format = File.extname(name)
    videoPost.video_status_id = VideoStatus.where(order: 1)[0].id
    videoPost.size = file[:video].size
    videoPost.first_name = file[:first_name]
    videoPost.last_name = file[:last_name]
    videoPost.email = file[:email]
    videoPost.message = file[:message]
    videoPost.contest_id = file[:contest_id]


    directory = "/videos/"
    video_path = File.join(directory, name)

    path = File.join("public/", video_path)


    videoPost.original_path = video_path

    File.open(path, "wb") { |f| f.write(file[:video].read) }
    videoPost.save
  end
end
