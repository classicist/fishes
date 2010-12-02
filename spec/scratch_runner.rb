require File.dirname(__FILE__) + '/spec_helper.rb'
require 'sinatra'

@@pond ||= Pond.new()

get '/start' do
  start = Time.now
  @command_line_args1 =  "mxmlc -load-config /Users/paul/Desktop/dumped_config.xml -output /Users/paul/Development/clickfox/repos/Current/com.clickfox.flex.app.cea/target/cfpotral.swf /Users/paul/Development/clickfox/repos/Current/com.clickfox.flex.app.cea/src/main/flex/cfportal.mxml"
   @command_line_args2 =  "mxmlc -load-config /Users/paul/Desktop/dumped_config.xml -output /Users/paul/Development/clickfox/repos/Current/com.clickfox.flex.app.cea/target/spike.swf /Users/paul/Development/clickfox/repos/Current/com.clickfox.flex.app.cea/src/main/flex/spike.mxml"
  
  @start_time = Time.now
  @fish1 = @@pond.add(@command_line_args1)
  @fish2 = @@pond.add(@command_line_args2)
  p "ids:", @@pond.object_id, @fish1.object_id, @fish1.pid
end

get '/stop' do
  @@pond.kill_all
  "all done"
end