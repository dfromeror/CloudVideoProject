class SqsService
  include ActiveModel::Model
  require 'aws-sdk'
  def self.send(msg)
    service = AWS::SQS.new
    q = service.queues.create("srgvideolibraryq")
    q.send_message(msg)
  end

  def self.read
    service = AWS::SQS.new
    q = service.queues.create("srgvideolibraryq")
    @msg = q.receive_message
    # q.poll do |msg|
    #   @msg = msg
    # end
    # @msg.body
  end
end