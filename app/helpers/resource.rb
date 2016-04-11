class Resource
  attr_reader :location
  attr_reader :loader
  attr_reader :validator

  def initialize(location, loader, validator=nil)
    @location = location
    @loader = loader
    @validator = validator
  end
  
  def load()
    loaded_resource = @loader.load(self)
    if validate(loaded_resource)
      loaded_resource
    else
      raise "The resource at #{@location} could not be loaded."
    end
  rescue
    nil
  end
  
  private
  
  def validate(loaded_resource)
    @validator ? @validator.validate(loaded_resource) : true
  end
end