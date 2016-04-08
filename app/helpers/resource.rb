class Resource
  attr_reader :location
  attr_reader :type
  attr_reader :validator

  def initialize(location, type, validator=nil)
    @location = location
    @type = type
    @validator = validator
  end
end