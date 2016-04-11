require 'json'
require 'open-uri'

class PhasesLoader
  def self.load(resource)
    JSON.load(open(resource.location))['phases']
  end
end