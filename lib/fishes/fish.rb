class Fish
  attr_reader :pid, :compiler_arguments, :exit_status
  TERM = "TERM"
  
  def initialize(compiler_arguments)
    @compiler_arguments = compiler_arguments
  end
    
  def start
    @pid = fork do

    end
  end
  
  def stop
    @exit_status = Process.kill TERM, pid if pid
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
