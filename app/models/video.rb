class Video

  dynamo_schema do
    attribute :converted_name
    attribute :converted_path
    attribute :first_name
    attribute :last_name
    attribute :email
    attribute :message
    attribute :size, :decimal
    attribute :conversion_date, :datetime
    attribute :contest_id, :integer
    attribute :video_status_id, :integer
    attribute :mime_type
    attribute :video_file_name
    attribute :video_content_type
    attribute :video_file_size, :integer
    attribute :video_updated_at, :datetime
    attribute :video_converted_file_name
    attribute :video_converted_content_type
    attribute :video_converted_file_size, :integer
    attribute :video_converted_updated_at, :datetime
  end

  belongs_to :contest
  has_one :video_status

  require 'aws-sdk-v1'
  require 'aws-sdk'



  self.per_page = 50

  has_attached_file :video,
                    :url => "/videos/:id/:filename"

  has_attached_file :video_converted,
                    :url => "/videos/:id/converted/:filename"

  validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

  def self.upload(file)
    name = file[:video].original_filename
    video_post = Video.new
    video_post.original_name = name
    video_post.original_format = File.extname(name)
    video_post.mime_type = MIME::Types.type_for(name).first.content_type
    video_post.video_status_id = VideoStatus.where(order: 1)[0].id
    video_post.size = file[:video].size
    video_post.first_name = file[:first_name]
    video_post.last_name = file[:last_name]
    video_post.email = file[:email]
    video_post.message = file[:message]
    video_post.contest_id = file[:contest_id]

    contest = Contest.find(file[:contest_id])

    contest_path = Rails.root.join("public", "videos", contest.name.squish.downcase.tr(" ", "_"))
    Dir.mkdir(contest_path) unless File.exist?(contest_path)
    base_name = File.basename(file[:video].original_filename.squish.downcase.tr(" ", "_"))

    video_path = Rails.root.join("public", "videos", contest.name.squish.downcase.tr(" ", "_"), base_name)

    #path = File.join("public/", video_path)


    video_post.original_path = video_path.to_s[Rails.root.join("public").to_s.size..-1]

    File.open(video_path, "wb") { |f| f.write(file[:video].read) }
    video_post.save
    return video_post
  end
end
