namespace :worker do
  task :convert_oldest_video do
    oldest_video = Video.where(:video_status_id => 1).order(created_at: :desc)[0]
    convert_to_mp4 oldest_video
  end
end