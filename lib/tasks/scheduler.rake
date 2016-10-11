desc "This task is called by the Heroku scheduler add-on"
require 'net/http'
require 'rake'

namespace :scheduler do
  desc "Ping our heroku dyno every 10, 60 or 3600 min"
  
  
  task :minutes => :environment do
    puts "Making the attempt to send email"
    watchers = Watcher.all
    #watchers.each do |watcher|
    parser = Parsewatcher.new
    Watcher.where("frequency = ?", 'min').find_each do |watcher|
      #puts watcher.domain
        parser.current?(watcher, watcher.content)
    end
  end
  
  task :hours => :environment do
    puts "Making the attempt to send email"
    watchers = Watcher.all
    #watchers.each do |watcher|
    parser = Parsewatcher.new
    Watcher.where("frequency = ?", 'hour').find_each do |watcher|
        parser.current?(watcher, watcher.content)
    end
  end
  
  task :days => :environment do
    puts "Making the attempt to send email"
    watchers = Watcher.all
    #watchers.each do |watcher|
    parser = Parsewatcher.new
    Watcher.where("frequency = ?", 'day').find_each do |watcher|
        parser.current?(watcher, watcher.content)
    end
  end
end