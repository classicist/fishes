$:.unshift(File.dirname(__FILE__))
require 'local_constants'

puts "This script copies the generic flex build file templates in ./xml to ./xml/local_build_config and replaces the generic paths to FLEX_HOME and the repository to those actual paths on your box. Those paths are set in conf/local_constants.\n...\nLocalized config files generated."

files = Dir.new("./xml").entries.map{ |filename| filename if !(filename =~ /^\..*/) && filename.include?(".template")}.compact

files.each do |file_name|
   initial_file_path   = "./xml/" + file_name
   processes_file_path = "./xml/local_build_config/" + file_name.gsub(".template", "")
   
  file = File.open(initial_file_path, "r")
  repository_base_replacements =  file.read.gsub("REPOSITORY_BASE_DIR", "#{REPOSITORY_BASE_DIR}")
  file.close
  
  if repository_base_replacements
    file = File.open(processes_file_path, "w")
    file.puts repository_base_replacements 
    file.close
  end
  
  file = File.open(processes_file_path, "r")
  flex_home_replacements =  file.read.gsub("FLEX_HOME", "#{FLEX_HOME}")
  file.close
   
  if flex_home_replacements
    file = File.open(processes_file_path, "w")
    file.puts flex_home_replacements 
    file.close
  end
end
