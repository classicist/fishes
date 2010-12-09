require 'net/http'
require 'uri'

class FishingPole
  BASE = "http://localhost"
  
  def self.cea
    cast("4560", this_method)
  end

  def self.cea_test
    cast("4562", this_method)
  end
  
  def self.stop
    cast("4560", this_method)
  end
  
  def self.login
    cast("4563", this_method)
  end
  
  def self.assets
    cast("4563", this_method)
  end
  
  def self.copy_assets
    cast("4563", this_method)
  end
  
  def self.cea_spike
    cast("4563", this_method)
  end
  
  def self.management
    cast("4561", this_method)
  end  
  
  def self.cast(port, url)
    Net::HTTP.get_print URI.parse("#{BASE}:#{port}/#{url}")
  end
  
  def self.this_method
    caller[0][/`([^']*)'/, 1]
  end
end