class Resource
  attr_reader :location
  attr_reader :type

  def initialize(location, type)
    @location = location
    @type = type
  end
  
  def load()
    loader = find_loader()
    loader.load(self)
  end
  
  private
    
  def find_loader()
    ResourceLoaders.constants.each do |loader_symbol|
      loader = ResourceLoaders.const_get(loader_symbol)
      return loader if loader::LOADER_FOR == @type
    end
  end
end