class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :message
      t.integer :status

      t.timestamps
    end
  end
end
