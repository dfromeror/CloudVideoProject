namespace :conver_video_task do
  desc "Convert all videos without convert"
  task convert_oldest_video: :environment do
    oldest_video = Video.where(:video_status_id => 1).order(created_at: :desc)[0]
    convert_to_mp4 oldest_video
  end
end