require 'open-uri'

class ERBLoader
  class << self
    def load(file_location)
      open(file_location).read
    end
  end
end