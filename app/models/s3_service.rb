class S3Service
  require 'aws-sdk-v1'
  require 'aws-sdk'
  include ActiveModel::Model

  def self.put(key, file)
    service = AWS::S3.new
    bucket_name = ENV['AWS_S3_BUCKET_NAME']
    bucket = service.buckets[bucket_name]
    bucket.acl = :public_read
    s3_file = bucket.objects[key].write(:file => file)
    s3_file.acl = :public_read
    return s3_file
  end

  def self.download(key, path)
    service = AWS::S3.new
    bucket_name = ENV['AWS_S3_BUCKET_NAME']
    bucket = service.buckets[bucket_name]
    File.open(path, 'wb') do |file|
      file.write(bucket.objects[key].read)
    end
  end
end