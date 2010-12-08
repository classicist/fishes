$:.unshift(File.dirname(__FILE__))
require 'local_constants'

files = Dir.new("./xml").entries.map{ |filename| filename unless filename =~ /^\..*/}.compact


