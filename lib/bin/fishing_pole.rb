require 'net/http'
require 'uri'

class FishingPole
  BASE = "http://localhost"
  
  def self.cea
    cast("4565", this_method)
  end

  def self.cea_test
    cast("5657", this_method)
  end
  
  def self.stop
    cast("4565", this_method)
  end
  
  def self.login
    cast("6789", this_method)
  end
  
  def self.assets
    cast("6789", this_method)
  end
  
  def self.copy_assets
    cast("6789", this_method)
  end
  
  def self.cea_spike
    cast("6789", this_method)
  end
  
  def self.management
    cast("7890", this_method)
  end  
  
  def self.cast(port, url)
    Net::HTTP.get_print URI.parse("#{BASE}:#{port}/#{url}")
  end
  
  def self.this_method
    caller[0][/`([^']*)'/, 1]
  end
end