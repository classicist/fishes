$:.unshift(File.dirname(__FILE__) + '/..')
require 'rubygems'
require 'fishes/fish'
require 'sinatra'
require '../conf/constants'
require 'change_watcher'

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
  source = ASSETS_BIN + "/" + ASSETS_LONG_NAME_SWC 
  cea_dest_dir = "#{REPOSITORY_BASE_DIR}/#{CEA_WEB_CONTENT}"
  man_dest_dir = "#{REPOSITORY_BASE_DIR}/#{MANAGEMENT_WEB_CONTENT}"
  
  unzip_swc = "echo 'unzipping:'; unzip -o #{source}; mv library.swf assets.swf;"
  remove_cruft='echo "removing cruft:"; find . -not -name "*assets.*" -exec rm -drfv {} \;'
  copy_artifacts_to_destinations="echo 'copying artifacts:'; cp -fv assets.swf #{cea_dest_dir}/assets.swf; cp -fv #{source} #{cea_dest_dir}/assets.swc; cp -fv assets.swf #{man_dest_dir}/assets.swf; cp -fv #{source} #{man_dest_dir}/assets.swc;"
  clean_up="echo 'cleaning up:'; rm -v assets.swf;"
      
  `cd #{ASSETS_BIN}; #{unzip_swc} #{copy_artifacts_to_destinations} #{clean_up} #{remove_cruft} `
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

ChangeRunner.start 