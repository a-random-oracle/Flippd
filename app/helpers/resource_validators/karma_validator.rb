require_relative 'json_validator'

class KarmaValidator
  def self.validate(resource)
    JSONValidator.validate(resource, self.schema)
  end

  def self.schema
    {
      "type": "object",
      "additionalProperties": {
        "type": "integer"
      }
    }
  end
end