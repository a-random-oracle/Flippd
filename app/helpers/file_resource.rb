require_relative 'resource'

class FileResource < Resource
  attr_reader :location

  def initialize(location, loader, validator=nil, default=nil, cache_timeout=1800)
    super(loader, validator, default)
    @location = location
  end
end