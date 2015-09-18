class AddColumnToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :mime_type, :string
  end
end
