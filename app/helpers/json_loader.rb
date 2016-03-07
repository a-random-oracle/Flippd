require 'json'
require 'open-uri'

class JSONLoader
  class << self
    def load(file_location)
      JSON.load(open(file_location))
    end
  end
end