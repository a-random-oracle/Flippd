require 'open-uri'

class ERBLoader
  def self.load(resource)
    open(resource.location).read
  end
end