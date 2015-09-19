class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :original_name
      t.string :converted_name
      t.string :original_format
      t.string :original_path
      t.string :converted_path
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :message
      t.decimal :size
      t.datetime :conversion_date

      t.timestamps
    end
  end
end
