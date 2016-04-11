class ResourceRequester
  class << self
    def request(resource)
      loaded_resource = load_resource(resource)
      validate_resource(resource, loaded_resource) ? loaded_resource : resource.default
    end

    private

    def find_loader(resource_type)
      ResourceLoaders.constants.each do |loader_symbol|
        loader = ResourceLoaders.const_get(loader_symbol)
        return loader if loader::LOADER_FOR == resource_type
      end
    end

    def load_resource(resource)
      loader = find_loader(resource.type)
      loader ? loader.load(resource) : nil
    end

    def validate_resource(resource, loaded_resource)
      validator = resource.validator
      validator ? validator.validate(loaded_resource) : true
    end
  end
end