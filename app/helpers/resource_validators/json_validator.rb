require 'json-schema'

class JSONValidator
  def self.validate(resource, schema)
    begin
      JSON::Validator.validate!(schema, resource)
    rescue JSON::Schema::ValidationError
      puts $!.message
      return false
    end
    true
  end
end