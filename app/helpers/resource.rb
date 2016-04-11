class Resource
  attr_reader :location
  attr_reader :type
  attr_reader :default
  attr_reader :validator

  def initialize(location, type, default, validator=nil)
    @location = location
    @type = type
    @default = default
    @validator = validator
  end
end