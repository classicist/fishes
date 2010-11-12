require File.dirname(__FILE__) + '/spec_helper.rb'

@command_line_args1 = "mxmlc -file-specs=/Users/paul/Development/Projects/fishes/spec/fixtures/FixtureApp.mxml -o=/Users/paul/Development/Projects/fishes/spec/fixtures/bin/FixtureApp1.swf"
@command_line_args2 = "mxmlc -file-specs=/Users/paul/Development/Projects/fishes/spec/fixtures/FixtureApp.mxml -o=/Users/paul/Development/Projects/fishes/spec/fixtures/bin/FixtureApp2.swf"
@pond = Pond.new()
@fish1 = @pond.add(@command_line_args1)
@fish2 = @pond.add(@command_line_args2)

@fish1.start
@fish2.start
@fish1.stop    
@fish2.stop    