require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'bin/cli'
require 'stringio'

describe Bin::CLI, "execute" do
  before(:each) do
    @stdout_io = StringIO.new
    @here = File.dirname(__FILE__)
    @mxmlFile = @here + "/fixtures/FixtureApp.mxml"
    @output = @here + "/fixtures/bin/CommandLineFixtureApp.swf"
    @command_line_args = "mxmlc -file-specs=#{@mxmlFile} -o=#{@output}"
  end
  
  after(:each) do
    Bin::CLI.reset
 #   File.delete @output if File.file? @output
  end
   
  it "should print that fish are dead" do
    pending
    run_option "-kill_all"
    @stdout.chomp.should == "all fish are dead, good job. :("
  end
  
  it "should print pond stuff" do
    pending
    run_option @command_line_args
    @stdout.chomp.should == @command_line_args 
    (File.file? @output).should be_true
  end
  
  def run_option(opt)
    Bin::CLI.execute(@stdout_io, [opt])
    @stdout_io.rewind
    @stdout = @stdout_io.read
  end
end