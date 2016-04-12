class Resource
  attr_reader :location
  attr_reader :loader
  attr_reader :default
  attr_reader :validator

  def initialize(location, loader, default=nil, validator=nil)
    @location = location
    @loader = loader
    @default = default
    @validator = validator
  end
  
  def load()
    loaded_resource = @loader.load(self)
    validate(loaded_resource) ? loaded_resource : @default
  rescue
    @default
  end
  
  private
  
  def validate(loaded_resource)
    @validator ? @validator.validate(loaded_resource) : true
  end
end