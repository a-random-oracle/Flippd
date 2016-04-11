require 'json'
require 'open-uri'

class JSONLoader
  def self.load(resource)
    JSON.load(open(resource.location))
  end
end