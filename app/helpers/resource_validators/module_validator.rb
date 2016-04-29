require_relative 'json_validator'

class ModuleValidator
  def self.validate(resource)
    JSONValidator.validate(resource, self.schema)
  end
  
  def self.schema
    {
      "type": "object",
      "properties": {
        "title": {
          "type": "string"
        },
        "phases": {
          "type": "array"
        }
      },
      "required": [
        "title",
        "phases"
      ],
      "additionalProperties": false
    }
  end
end