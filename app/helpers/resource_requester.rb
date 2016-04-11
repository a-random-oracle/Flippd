class ResourceRequester
  class << self
    def request(resource)
      loaded_resource = resource.loader.load(resource)
      validate_resource(resource, loaded_resource) ? loaded_resource : resource.default
    end

    private

    def validate_resource(resource, loaded_resource)
      resource.validator ? resource.validator.validate(loaded_resource) : true
    end
  end
end