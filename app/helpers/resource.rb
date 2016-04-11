class Resource
  attr_reader :location
  attr_reader :loader
  attr_reader :default
  attr_reader :validator

  def initialize(location, loader, default, validator=nil)
    @location = location
    @loader = loader
    @default = default
    @validator = validator
  end
end