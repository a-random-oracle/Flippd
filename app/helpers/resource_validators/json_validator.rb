require 'json-schema'

class JSONValidator
  def self.validate(resource, schema)
    JSON::Validator.validate(schema, resource)
  end
end