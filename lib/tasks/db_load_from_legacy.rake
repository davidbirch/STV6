# lib/tasks/load_from_legacy.rake
namespace :db do
    task :load_from_legacy => :environment do
      load 'db/load_from_legacy.rb'
    end
  end