$:.unshift(File.dirname(__FILE__) + '/..')
require 'optparse'
require 'fishes/fish'
  
module Bin
  class CLI
    KILL_ALL = "kill_all"
    KILL_ALL_MESSAGE = "all fish are dead, good job. :("
    KILL_ALL_HELP_MESSAGE = "Kills all the fish in the pond -- careful!"
    HELP_MESSAGE = "Show this help message."
    OPTS_SEPARATOR = ""
    COMPILE_MESSAGE = "Needed to pass args to FCSH"
    COMPILE = "compile"
    @@options = {}
    
    BANNER = <<-BANNER.gsub(/^          /,'')
        Compiles Adobe Flex applications using FCSH
        
          Usage: #{File.basename($0)} [mxmlc]

          Options are:
          -#{KILL_ALL} #{KILL_ALL_HELP_MESSAGE}
          -h, --help, #{HELP_MESSAGE}
        BANNER
    
    def self.execute(stdout, arguments=[])
      @@pond    = Pond.new
      @@stdout  = stdout
      arguments = parse_arguments(stdout, arguments)
      add_command_to_pond arguments
      cleanup_execution
    end
    
    def self.add_command_to_pond(arguments)
      @@pond.add arguments[0]
      @@stdout.puts arguments[0]
    end
    
    def self.parse_arguments(stdout, arguments)      
      parser = OptionParser.new do |opts|
        opts.banner = BANNER
        opts.separator OPTS_SEPARATOR
        opts.on("-k", "-#{KILL_ALL}", String, KILL_ALL_MESSAGE) { |arg| @@options[:kill_all] = arg }
        opts.on("-h", "--help",       String, HELP_MESSAGE)     { stdout.puts opts; exit }
        opts.parse!(arguments)

        if @@options[:kill_all]
          kill_all(stdout)
          exit
        end     
      end
      
      arguments
    end
    
    def self.kill_all(stdout)
      at_exit {
        @@pond.kill_all
        @@options[:kill_all] = nil
        stdout.puts KILL_ALL_MESSAGE
      }
      exit
    end
    
    def self.cleanup_execution
     # @@stdout = nil
    end
    
    def self.reset
       @@pond.kill_all
       @@pond = nil
       @@options = {}
       cleanup_execution
    end
  end
end 

#Bin::CLI.execute(STDOUT, ["-kill_all"])