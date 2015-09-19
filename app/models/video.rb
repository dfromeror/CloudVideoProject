class Video < ActiveRecord::Base
  belongs_to :contest
  has_one :video_status

  def self.upload(file)
    name = file[:video].original_filename
    videoPost = Video.new
    videoPost.original_name = name
    videoPost.original_format = File.extname(name)
    videoPost.mime_type = MIME::Types.type_for(name).first.content_type
    videoPost.video_status_id = VideoStatus.where(order: 1)[0].id
    videoPost.size = file[:video].size
    videoPost.first_name = file[:first_name]
    videoPost.last_name = file[:last_name]
    videoPost.email = file[:email]
    videoPost.message = file[:message]
    videoPost.contest_id = file[:contest_id]

    contest = Contest.find(file[:contest_id])

    contest_path = Rails.root.join("public", "videos", contest.name.squish.downcase.tr(" ", "_"))
    Dir.mkdir(contest_path) unless File.exist?(contest_path)
    base_name = File.basename(file[:video].original_filename.squish.downcase.tr(" ", "_"))

    video_path = Rails.root.join("public", "videos", contest.name.squish.downcase.tr(" ", "_"), base_name)

    #path = File.join("public/", video_path)


    videoPost.original_path = video_path.to_s[Rails.root.join("public").to_s.size..-1]

    File.open(video_path, "wb") { |f| f.write(file[:video].read) }
    videoPost.save
    return videoPost
  end
end
