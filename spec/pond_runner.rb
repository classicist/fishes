require File.dirname(__FILE__) + '/spec_helper.rb'
require 'sinatra'

@@pond ||= Pond.new()

CEA_CONFIG = "/Users/monster/Desktop/cea_dumped_config.xml"
CEA_INPUT  = "/Users/monster/Development/repos/Current/com.clickfox.flex.app.cea/src/main/flex/cfportal.mxml"
CEA_OUTPUT = "/Users/monster/Development/repos/Current/com.clickfox.app.cea/WebContent/cfpotral.swf"

get '/cea' do
   @cea_args =  "mxmlc -load-config #{CEA_CONFIG} -output #{CEA_OUTPUT} #{CEA_INPUT}"
   @@pond.add(@cea_args)
   "CEA Compile"
end

ASSETS_CONFIG = "/Users/monster/Desktop/assets_dumped_config.xml"
ASSETS_INPUT  = "/Users/monster/Development/repos/Current/com.clickfox.flex.library.assets/src"
ASSETS_OUTPUT = "/Users/monster/Development/repos/Current/com.clickfox.app.cea/WebContent/assets.swc"

get '/assets' do
   @cea_args =  "compc -load-config #{ASSETS_CONFIG} -output #{ASSETS_OUTPUT} -source-path #{ASSETS_INPUT}"
   @@pond.add(@cea_args)
   "CEA Compile"
end


get '/stop' do
  @@pond.kill_all
  "all done"
end

#TODO
# 1. Have fish write out to individual log files
# 2. Watch those files for changes
# 3. Have sinatra make the browser poll for the changes
# 4. Cleanup those files in Pond#kill_all

#http://paulhorman.com/filesystemwatcher/
#require "filesystemwatcher"
#
#watcher = FileSystemWatcher.new()
#watcher.addDirectory("/inetpub/ftproot", "*.xml")
#watcher.sleepTime = 10
#watcher.start { |status,file|
#    if(status == FileSystemWatcher::CREATED) then
#        puts "created: #{file}"
#    elsif(status == FileSystemWatcher::MODIFIED) then
#        puts "modified: #{file}"
#    elsif(status == FileSystemWatcher::DELETED then
#        puts "deleted: #{file}"
#    end
#}
#
#watcher.join() # join to the thread to keep the program alive 