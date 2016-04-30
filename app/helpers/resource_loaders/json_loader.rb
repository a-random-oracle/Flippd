require 'json'
require 'open-uri'

class JSONLoader
  def self.load(file_location)
    JSON.load(open(file_location))
  end
end