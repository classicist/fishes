require 'pty'
class Fish
  attr_reader :pid, :compiler_arguments, :exit_status, :fcsh_path
  attr_accessor :fish
  
  TERM = "TERM"
  
  def initialize(compiler_arguments, path=nil)
    @compiler_arguments = compiler_arguments
    @fcsh_path = path || ENV['FLEX_HOME'] + "/bin/fcsh"
  end
    
  def start
    return unless @compiler_arguments
    @args = @pid ? "compile 1" : @compiler_arguments
    run_process
    @pid 
  end
  
  def run_process
    if @fish
      @fish.puts(@args)
    else
      @t = Thread.new do
        IO.popen(@fcsh_path, "w+") do |io|             
          @pid = io.pid
          @fish = io
          io.puts @args
          io.each { |line| print line}
        end
      end
    end
  end
  
  def stop
    return @exit_status unless @fish
    @exit_status = Process.kill(TERM, @fish.pid)
    @fish.close
    @fish = nil
    @pid = nil
    @exit_status
  end
  
  def ==(other)
    return false if other.nil?
    other.hash == hash
  end
  
  def eql?(other)
    return false if other.nil?
    other.class === Fish && other.hash == hash
  end
  
  def hash
    @compiler_arguments.hash
  end  
end


class Pond  
  def initialize(path=nil)
    @path = path
    @fishes = Hash.new
  end
  
  def size
    @fishes.length
  end
  
  def add(compiler_arguments)
    fish = @fishes[compiler_arguments] ||= Fish.new(compiler_arguments, @path)
    fish.start
    fish
  end
  
  def remove(compiler_arguments)
    @fishes[compiler_arguments] && @fishes[compiler_arguments].stop
    @fishes.delete compiler_arguments
  end
  
  def recompile_all
    @fishes.each{ |fish|  fish.start }
  end
  
  def kill_all
    @fishes.each{ |compiler_arguments, fish|  fish.stop }
    @fishes = Hash.new
  end
end