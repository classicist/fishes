$:.unshift(File.dirname(__FILE__) + "/..")
require 'change_watcher'

class ChangeRunner
  def self.start
    @@change_watcher = ChangeWatcherPool.new    
    recompile_management_after_dependant_compile
    recompile_cea_after_dependant_compile
    copy_assests_after_compile_and_recompile_login
  end

private
  def self.copy_assests_after_compile_and_recompile_login
    recompile ASSETS_BIN, "*.swc", ["copy_assets", "login"]             
  end
  
  def self.recompile_cea_after_dependant_compile
    recompile CEA_BIN, "assets.swf", ["cea", "cea_test","cea_spike"]         
  end

  def self.recompile_management_after_dependant_compile   
    recompile MANAGEMENT_BIN, "assets.swf",["management"]   
  end
  
  def self.recompile(dir, file_pattern, call_backs)
    puts "started watching #{dir}"
    watcher = @@change_watcher.get(dir, file_pattern)
    call_backs.each { |call_back|  watcher.start call_back }
  end
end
