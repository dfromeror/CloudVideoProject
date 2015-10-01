module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
Paperclip::Attachment.default_options[:s3_host_name] = 'sa-east-1.amazonaws.com'