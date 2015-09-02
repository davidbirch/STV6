# config/initializers/delayed_job.rb
Delayed::Worker.sleep_delay = 60
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))