require 'open-uri'

class ERBLoader
  def self.load(file_location)
    open(file_location).read
  end
end