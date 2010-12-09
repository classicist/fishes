#details at:
#http://paulhorman.com/filesystemwatcher/
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require "filesystemwatcher"
require "bin/fishing_pole"
require 'daemons'
require '../conf/constants'
require 'sinatra'

class ChangeWatcher
  attr_accessor :watcher, :started
  
  def initialize(dir_to_watch, file_name_match_to_watch = "*", delay = 1)
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
  @@watchers = {}

  def get(dir_to_watch, file_name_match_to_watch = "*")
    @@watchers[dir_to_watch + file_name_match_to_watch] ||= ChangeWatcher.new(dir_to_watch, file_name_match_to_watch)
  end
end

class ChangeRunner
  def self.start
    puts "started watching #{ASSETS_BIN}"
    @@change_watcher = ChangeWatcherPool.new
    @@watcher = @@change_watcher.get(ASSETS_BIN, "*.swc")
    @@watcher.start "copy_assets" 
  end
end

