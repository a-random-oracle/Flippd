class ResourceRequester
  class << self
    def request(resource)
      loaded_resource = load_resource(resource)
      result = validate_resource(resource, loaded_resource) ? loaded_resource : resource.default
      
      if block_given?
        yield result
      else
        result
      end
    end

    private

    def load_resource(resource)
      resource.loader.load(resource)
    rescue
      nil
    end

    def validate_resource(resource, loaded_resource)
      resource.validator ? resource.validator.validate(loaded_resource) : true
    end
  end
end