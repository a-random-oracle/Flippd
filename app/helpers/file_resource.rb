require_relative 'resource'

class FileResource < Resource
  attr_reader :location

  def initialize(location, loader, validator=nil, default=nil)
    super(loader, validator, default)
    @location = location
  end
end