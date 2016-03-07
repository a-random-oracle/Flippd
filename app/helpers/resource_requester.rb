class ResourceRequester
  class << self
    def request(resource)
      loader = find_loader(resource.type)
      loader.load(resource)
    end
    
    private
    
    def find_loader(resource_type)
      ResourceLoaders.constants.each do |loader_symbol|
        loader = ResourceLoaders.const_get(loader_symbol)
        return loader if loader::LOADER_FOR == resource_type
      end
    end
  end
end