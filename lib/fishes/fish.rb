class Fish
  attr_reader :pid, :compiler_arguments, :exit_status, :fcsh_path
  
  TERM = "TERM"
  
  def initialize(compiler_arguments, path=nil)
    @compiler_arguments = compiler_arguments
    @fcsh_path = path || ENV['FLEX_HOME'] + "/bin/fcsh"
  end
    
  def start
    return unless @compiler_arguments
    $stdout.sync = true
    @args = pid ? "compile 1" : @compiler_arguments
    @fish ||= IO.popen(@fcsh_path, "w+")
    @pid = @fish.pid
    puts read_to_prompt(@fish) + @args
    @fish.puts(@args)
    puts read_to_prompt(@fish)
    @pid
  end
  
  def stop
    return @exit_status unless @fish
    @exit_status = Process.kill(TERM, @fish.pid)
    @fish.close
    @fish = nil
    @pid = nil
    @exit_status
  end
  
  def read_to_prompt(fcsh)
    fcsh.gets
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
    @fishes.each{ |args, fish|  fish.stop }
    @fishes = Hash.new
  end
end