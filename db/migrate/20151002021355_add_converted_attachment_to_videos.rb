class AddConvertedAttachmentToVideos < ActiveRecord::Migration
  def up
    add_attachment :videos, :video_converted
  end
  def down
    remove_attachment :videos, :video_converted
  end
end
