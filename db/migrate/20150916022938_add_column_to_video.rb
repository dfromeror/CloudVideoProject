class AddColumnToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :contest_id, :integer
    add_column :videos, :video_status_id, :integer
  end
end
