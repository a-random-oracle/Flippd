class Resource
  attr_reader :loader
  attr_reader :validator
  attr_reader :default

  def initialize(loader, validator=nil, default=nil)
    @loader = loader
    @default = default
    @validator = validator
  end
  
  def load
    loaded_resource = @loader.load(self)
    validate(loaded_resource) ? loaded_resource : @default
  rescue
    @default
  end
  
  def with
    yield load
  end
  
  private
  
  def validate(loaded_resource)
    @validator ? @validator.validate(loaded_resource) : true
  end
end