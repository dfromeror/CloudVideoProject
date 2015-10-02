module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
Paperclip::Attachment.default_options[:s3_host_name] = 's3-sa-east-1.amazonaws.com'
# https://s3-sa-east-1.amazonaws.com