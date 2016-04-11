class Resource
  attr_reader :location
  attr_reader :loader

  def initialize(location, loader)
    @location = location
    @loader = loader
  end
  
  def load()
    @loader.load(self)
  rescue
    nil
  end
end