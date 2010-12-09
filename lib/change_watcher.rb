#details at:
#http://paulhorman.com/filesystemwatcher/
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require "watcher/filesystemwatcher"
require "bin/fishing_pole"
require '../conf/constants'

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
  @watchers = {}

  def get(dir_to_watch, file_name_match_to_watch = "*")
    @watchers[dir_to_watch + file_name_match_to_watch] ||= ChangeWatcher.new(dir_to_watch, file_name_match_to_watch)
  end
end

class ChangeRunner
  def self.start
    @@change_watcher = ChangeWatcherPool.new    
    recompile_management_after_dependant_compile
    recompile_cea_after_dependant_compile
    copy_assests_after_compile_and_recompile_login
  end

private
  def self.copy_assests_after_compile_and_recompile_login
    recompile ASSETS_BIN, "*.swc", ["copy_assets", "login"]             
  end
  
  def self.recompile_cea_after_dependant_compile
    recompile CEA_WEB_CONTENT, "/(assets)|(LoginModule)\.swf/", ["cea", "cea_test","cea_spike"]         
  end

  def self.recompile_management_after_dependant_compile   
    recompile MANAGEMENT_WEB_CONTENT, "/(assets)|(LoginModule)\.swf/",["management"]   
  end
  
  def self.recompile(dir, file_pattern, call_backs)
    puts "started watching #{dir}"
    watcher = @@change_watcher.get(dir, file_pattern)
    call_backs.each { |call_back|  watcher.start call_back )
  end
end

