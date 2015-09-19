# Options
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 5.minutes
Delayed::Worker.read_ahead = 10
Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.raise_signal_exceptions = :term
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))

if Rails.env.development?
  system "RAILS_ENV=development #{Rails.root.join('script','delayed_job')} stop"
  system "RAILS_ENV=development #{Rails.root.join('script','delayed_job')} -n 2 start"
elsif Rails.env.production?
  system "RAILS_ENV=production #{Rails.root.join('script','delayed_job')} stop"
  system "RAILS_ENV=production #{Rails.root.join('script','delayed_job')} -n 2 start"
end