class RemoveOriginalNameFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :original_name
    remove_column :videos, :original_format
    remove_column :videos, :original_path
  end
  def down
    add_column :videos, :original_name, :string
    add_column :videos, :original_format, :string
    add_column :videos, :original_path, :string
  end
end
