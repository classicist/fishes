require File.dirname(__FILE__) + '/spec_helper.rb'

COMPILER_PATH = nil
REASON = "Rspec dies when it tries to run the nested processes. TODO: Figure this out"

describe "Fish" do
  before(:each) do
    @here = File.dirname(__FILE__)
    @mxmlFile = @here + "/fixtures/FixtureApp.mxml"
    @output = @here + "/fixtures/bin/FixtureApp.swf"
    @command_line_args = "mxmlc -file-specs=#{@mxmlFile} -o=#{@output}"
    @fish = Fish.new(@command_line_args, COMPILER_PATH)
  end
  
  after(:each) do
    @fish.stop();
    @fish = nil
    File.delete @output if File.file? @output
  end
  
  it "should find a fish" do
    @fish.should_not == nil
  end
  
  it "should hold a process id" do
    @fish.pid.should be_nil
  end
  
  it "should be equal by its arguments" do
    fish = Fish.new(@command_line_args, COMPILER_PATH)
    @fish.should == fish
    @fish.should.eql? fish
  end
  
  it "should have a hashcode equal to that of its commandline arguments" do
    @fish.hash.should == @command_line_args.hash
  end
  
  it "should fork a process" do
    pending(REASON)
    @fish.start.should_not be_nil
  end
  
  it "should stop a forked process" do
    pending(REASON)
    @fish.start
    @fish.start
    @fish.stop.should == 1
    @fish.pid.should be_nil
  end
end

describe "Pond" do
  before(:each) do
    @pond = Pond.new(COMPILER_PATH)
    @here = File.dirname(__FILE__)
    @mxmlFile = "mxmlc " + @here + "/fixtures/FixtureApp.mxml"
    @output = "mxmlc " + @here + "/fixtures/bin/FixtureApp.swf"
    @command_line_args = "-sp #{@mxmlFile} -o #{@output}"
  end
  
  after(:each) do
    @pond.kill_all
    @pond = nil
    File.delete @output if File.file? @output
  end
  
  it "should find a pond" do
    @pond.should_not == nil
  end
  
  it "should add a fish" do
    pending(REASON)
    @pond.add(@command_line_args).pid.should_not be_nil
  end
  
  it "should remove a fish" do
    pending(REASON)
    @pond.add(@command_line_args).pid.should_not be_nil
    @pond.remove(@command_line_args)
    @pond.size.should == 0
  end
end