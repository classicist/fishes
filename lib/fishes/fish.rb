class Fish
  attr_reader :pid, :compiler_arguments

  def initialize(compiler_arguments)
    @pid = "3"
    @compiler_arguments = compiler_arguments
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
