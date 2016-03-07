require 'json'
require 'open-uri'

module ResourceLoaders
  class JSONLoader
    LOADER_FOR = :json

    def self.load(resource)
      JSON.load(open(resource.location))
    end
  end
end