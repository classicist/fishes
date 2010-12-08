$:.unshift(File.dirname(__FILE__))
require 'local_constants'

files = Dir.new("./xml").entries.map{ |filename| filename unless filename =~ /^\..*/}.compact

files.each do |file_name|
  
  file = File.open("./xml/" + file_name, "r")
  repository_base_replacements =  file.read.gsub("REPOSITORY_BASE_DIR", "#{REPOSITORY_BASE_DIR}")
  file.close
  
  if repository_base_replacements
    file = File.open("./xml/" + file_name, "w")
    file.puts repository_base_replacements 
    file.close
  end
  
  file = File.open("./xml/" + file_name, "r")
  flex_home_replacements =  file.read.gsub("FLEX_HOME", "#{FLEX_HOME}")
  file.close
   
  if flex_home_replacements
    file = File.open("./xml/" + file_name, "w")
    file.puts flex_home_replacements 
    file.close
  end
end
