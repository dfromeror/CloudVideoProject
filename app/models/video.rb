class Video
  include Dynamoid::Document
  table :name => :videos, :key => :id, :read_capacity => 1, :write_capacity => 1

  belongs_to :contest
  has_one :video_status

  field :first_name
  field :last_name
  field :email
  field :message
  field :size
  field :conversion_date, :datetime
  field :contest_id
  field :video_status_id
  field :original_file_name
  field :original_file_path
  field :original_file_format
  field :original_content_type
  field :original_file_size, :integer
  field :original_key
  field :converted_file_name
  field :converted_file_path
  field :converted_content_type
  field :converted_file_size, :integer
  field :converted_updated_at
  field :converted_key

  require 'aws-sdk-v1'
  require 'aws-sdk'

  #self.per_page = 50

  # has_attached_file :video,
  #                   :url => "/videos/:id/:filename"
  #
  # has_attached_file :video_converted,
  #                   :url => "/videos/:id/converted/:filename"
  #
  # validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

  def self.upload(file)
    contest_id = file[:contest_id]
    video_status = VideoStatus.where(:order => 1).all[0]

    name = file[:video].original_filename
    video_post = Video.new
    video_post.original_file_name = name
    video_post.original_file_format = File.extname(name)
    video_post.original_content_type = MIME::Types.type_for(name).first.content_type
    video_post.original_file_size = file[:video].size

    video_post.video_status_id = video_status.id
    video_post.first_name = file[:first_name]
    video_post.last_name = file[:last_name]
    video_post.email = file[:email]
    video_post.message = file[:message]
    video_post.contest_id = contest_id

    key = File.join("original", "#{contest_id}", "#{DateTime.now.to_i}", "#{name}")
    #Subir archivo a S3
    s3_file = S3Service.put(key, file[:video])

    #Actualizar los datos del video en base de datos
    video_post.original_file_path = s3_file.public_url.to_s
    video_post.original_key = key
    video_post.save

    #Encolar el transcode del video
    SqsService.send(video_post.id)

    return video_post
  end
end
