class AddColumnToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :contest_id, :integer
  end
end
