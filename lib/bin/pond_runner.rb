$:.unshift(File.dirname(__FILE__) + '/..')
require 'rubygems'
require 'fishes/fish'
require 'sinatra'
require '../conf/constants'

@@pond ||= Pond.new()

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

get '/copy_assets' do
  source = ASSETS_BIN + "/com.clickfox.flex.library.assets.swc" 
  dest_dir = "#{REPOSITORY_BASE_DIR}/com.clickfox.app.cea/WebContent"
  `cd #{ASSETS_BIN}; unzip #{source}; mv library.swf assets.swf; mv assets.swf #{dest_dir}; cp #{source} #{dest_dir}/assets.swc`
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