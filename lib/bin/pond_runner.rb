$:.unshift(File.dirname(__FILE__) + '/..')
require 'rubygems'
require 'fishes/fish'
require 'sinatra'
require '../conf/constants'

@@pond ||= Pond.new()

get "/" do
  "URLs are:\n" + "cea\n" + "cea_test\n" + "management\n" + "login\n" + "assets\n" + "copy_assets\n" + "stop\n"
end

get '/cea' do
   @cea_args =  "mxmlc -load-config #{CEA_CONFIG} -output #{CEA_OUTPUT} #{CEA_INPUT}"
   @@pond.add(@cea_args)
   "CEA Compile"
end

get '/cea_test' do
   @cea_test_args = "mxmlc #{CEA_TEST_ARGS}"
   @@pond.add(@cea_test_args)
   "CEA UnitTest Compile"
end

get '/cea_spike' do
   @cea_args =  "mxmlc -load-config #{CEA_CONFIG} -output #{CEA_SPIKE_OUT} #{CEA_SPIKE_IN}"
   @@pond.add(@cea_args)
   "CEA Spike Compile"
end

get '/management' do
   @cea_args =  "mxmlc -load-config #{MANAGEMENT_CONFIG} -output #{MANAGEMENT_OUTPUT} #{MANAGEMENT_INPUT}"
   @@pond.add(@cea_args)
   "Management Compile"
end

get '/login' do
   @cea_args =  "mxmlc -load-config #{LOGIN_CONFIG} -output #{LOGIN_OUTPUT} #{LOGIN_INPUT}"
   @@pond.add(@cea_args)
   "Login Module Compile"
end

get '/copy_assets' do
  source = ASSETS_BIN + "/com.clickfox.flex.library.assets.swc" 
  cea_dest_dir = "#{REPOSITORY_BASE_DIR}/#{CEA_WEB_CONTENT}"
  man_dest_dir = "#{REPOSITORY_BASE_DIR}/#{MANAGEMENT_WEB_CONTENT}"
  `cd #{ASSETS_BIN}; unzip -o #{source}; mv library.swf assets.swf; cp -f assets.swf #{cea_dest_dir}/assets.swf; cp -f #{source} #{cea_dest_dir}/assets.swc; cp -f assets.swf #{man_dest_dir}/assets.swf; cp -f #{source} #{man_dest_dir}/assets.swc`
end

get '/assets' do
   @cea_args =  "compc -load-config #{ASSETS_CONFIG} -output #{ASSETS_OUTPUT} -source-path #{ASSETS_INPUT}"
   @@pond.add(@cea_args)
   "CEA Assets Compile"
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