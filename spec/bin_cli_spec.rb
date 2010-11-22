require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'bin/cli'
require 'stringio'

describe Bin::CLI, "execute" do
  before(:each) do
    @stdout_io = StringIO.new
  end
  
  it "should print default output" do
    run_option "mxmlc"
    @stdout.should == "mxmlc" 
  end
  
    it "should print default output" do
    run_option "compc"
    @stdout.should == "compc" 
  end
  
  it "should print the help" do
    get_help
    @stdout.should == "grubmle" 
  end
  
  def run_option(opt)
    Bin::CLI.execute(@stdout_io, [opt])
    @stdout_io.rewind
    @stdout = @stdout_io.read
  end
  
  def get_help
    Bin::CLI.execute(@stdout_io, ["-h"])
    @stdout_io.rewind
    @stdout = @stdout_io.read
  end
end