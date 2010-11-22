require 'optparse'

module Bin
  class CLI
    def self.execute(stdout, arguments=[])

      options = {
        :mxmlc => 'mxmlc',
        :compc => 'compc'
      }
      
      mandatory_options = %w( )

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
        Compiles Adobe Flex applications using FCSH
        
          Usage: #{File.basename($0)} [mxmlc]

          Options are:
          -mxmlc  Use mxmlc compiler in FCSH
          -compc  Use compc compiler in FCSH
        BANNER
        opts.separator ""
        opts.on("-mxmlc", "mxmlc", String,
                "Use mxmlc compiler in FCSH") { |arg| options[:mxmlc] = arg }
        opts.on("-compc", "compc", String,
                "Use compc compiler in FCSH") { |arg| options[:compc] = arg }                
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end



      stdout.print options[arguments[0].to_sym]
    end
  end
end 