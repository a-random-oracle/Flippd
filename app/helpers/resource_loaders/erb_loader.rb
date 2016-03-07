require 'open-uri'

module ResourceLoaders
  class ERBLoader
    LOADER_FOR = :erb

    def self.load(resource)
      open(resource.location).read
    end
  end
end