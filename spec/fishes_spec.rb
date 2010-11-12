require File.dirname(__FILE__) + '/spec_helper.rb'

COMPILER_PATH = "#{File.dirname(__FILE__)}/fixture_script"

describe "Fish" do
  before(:each) do
    @command_line_args = "mxmlc command_line_arguments"
    @fish = Fish.new(@command_line_args, COMPILER_PATH)
  end
  
  after(:each) do
    @fish.stop();
    @fish = nil 
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
    @fish.start.should_not be_nil
  end
  
  it "should stop a forked process" do
    @fish.start
    @fish.start
    @fish.stop.should == 1
    @fish.pid.should be_nil
  end
end

describe "Pond" do
  before(:each) do
    @command_line_args_1 = "mxmlc command_line_arguments_1"
    @command_line_args_2 = "mxmlc command_line_arguments_2"
    @pond = Pond.new(COMPILER_PATH)
  end
  
  after(:each) do
    @pond.kill_all
    @pond = nil
  end
  
  it "should find a pond" do
    @pond.should_not == nil
  end
  
  it "should add a fish" do
    @pond.add(@command_line_args_1).pid.should_not be_nil
  end
  
  it "should remove a fish" do
    @pond.add(@command_line_args_1).pid.should_not be_nil
    @pond.remove(@command_line_args_1)
    @pond.size.should == 0
  end
end