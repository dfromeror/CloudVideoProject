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
  field :converted_file_name
  field :converted_file_path
  field :converted_content_type
  field :converted_file_size, :integer
  field :converted_updated_at

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
    #configuración del registro video
    contest = Contest.find(file[:contest_id])
    video_status = VideoStatus.where(:order => 1).all[0]

    name = file[:video].original_filename
    video_post = Video.create
    video_post.original_file_name = name
    video_post.original_file_format = File.extname(name)
    video_post.original_content_type = MIME::Types.type_for(name).first.content_type
    video_post.original_file_size = file[:video].size

    video_post.video_status_id = VideoStatus.where(:order => 1).all[0].id
    video_post.first_name = file[:first_name]
    video_post.last_name = file[:last_name]
    video_post.email = file[:email]
    video_post.message = file[:message]
    video_post.contest_id = file[:contest_id]

    #contest = Contest.find(file[:contest_id])

    #Conexion y bucket de S3
    service = AWS::S3.new(:access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
                          :secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'])

    bucket_name = 'srgvideolibrary'
    #if service.buckets.include?(bucket_name)
      bucket = service.buckets[bucket_name]
    #else
    #  bucket = service.buckets.create(bucket_name)
    #end
    bucket.acl = :public_read
    key = File.join("original", "#{contest.id}", "#{DateTime.now.to_i}", "#{name}")
    s3_file = bucket.objects[key].write(:file => file[:video])
    s3_file.acl = :public_read
    #configuracion del archivo a subir
    #video_path = File.join("original", "#{contest.id}", "#{DateTime.now.to_i}", "#{name}")

    #bucket.files.create(:key => video_path, :body => File.open(file[:video]))
    video_post.original_file_path = s3_file.public_url.to_s


    # contest_path = Rails.root.join("public", "videos", contest.name.squish.downcase.tr(" ", "_"))
    # Dir.mkdir(contest_path) unless File.exist?(contest_path)
    # base_name = File.basename(file[:video].original_filename.squish.downcase.tr(" ", "_"))
    #
    # video_path = Rails.root.join("public", "videos", contest.name.squish.downcase.tr(" ", "_"), base_name)
    #
    # #path = File.join("public/", video_path)
    #
    #
    # video_post.original_path = video_path.to_s[Rails.root.join("public").to_s.size..-1]
    #
    # File.open(video_path, "wb") { |f| f.write(file[:video].read) }

    video_post.save
    return video_post
  end
end
