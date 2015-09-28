class AddAttachmentVideoToVideos < ActiveRecord::Migration
  def up
    add_attachment :videos, :video
  end

  def down
    remove_attachment :videos, :video
  end
end
