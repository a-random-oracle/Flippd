class Resource
  attr_reader :location
  attr_reader :type

  def initialize(location, type)
    @location = location
    @type = type
  end
end