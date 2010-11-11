require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/

describe "Place your specs here" do
  before(:each) do
    @command_line_args = "command line arguments"
    @fish = Fish.new(@command_line_args)
  end
  
  after(:each) do
    @fish = nil
  end
  
  it "should find a fish" do
    @fish.should_not == nil
  end
  
  it "should hold a process id" do
    @fish.pid.should_not be_nil
  end
  
  it "should be equal by its arguments" do
    fish = Fish.new(@command_line_args)
    @fish.should == fish
    @fish.should.eql? fish
  end
  
  it "should have a hashcode equal to that of its commandline arguments" do
    @fish.hash.should == @command_line_args.hash
  end
  
  it "should fork a process" do
    
  end
end
