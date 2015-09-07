class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :media
      t.string :url
      t.datetime :start_date
      t.datetime :end_date
      t.string :award_description

      t.timestamps
    end
  end
end
