require_relative 'json_validator'

class UsersValidator
  def self.validate(resource)
    JSONValidator.validate(resource, self.schema)
  end
  
  def self.schema
    {
      "type": "object",
      "additionalProperties": {
        "type": "array",
        "items": {
          "type": "string"
        } 
      }
    }
  end
end