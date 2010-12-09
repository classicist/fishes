#details at:
#http://paulhorman.com/filesystemwatcher/
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require "watcher/filesystemwatcher"
require "bin/fishing_pole"

class ChangeWatcher
  attr_accessor :watcher, :started
  
  def initialize(dir_to_watch, file_name_match_to_watch = "*", delay = 3)
    @watcher = FileSystemWatcher.new(dir_to_watch, file_name_match_to_watch)
    watcher.addDirectory(dir_to_watch, file_name_match_to_watch)
    watcher.sleepTime = delay
    @watcher.priority = 1
  end
  
  def start(method_name)    
    return if @started
    @started = true
      @watcher.start do |status, file|
        FishingPole.send(method_name.to_sym) if(status == FileSystemWatcher::CREATED || status == FileSystemWatcher::MODIFIED)
      end            
    end
end#EOC


class ChangeWatcherPool
  def initialize
    @watchers = {}    
  end
  
  def get(dir_to_watch, file_name_match_to_watch = "*")
    @watchers[dir_to_watch + file_name_match_to_watch.to_s] ||= ChangeWatcher.new(dir_to_watch, file_name_match_to_watch)
  end
end
