class PhasesValidator
  def self.validate(resource)
    resource.each do |phase|
      if !JSONValidator.validate(phase, self.schema)
        return false
      end
      true
    end
  end
  
  def self.schema
    {
      "type": "object",
      "properties": {
        "title": {
          "type": "string"
        },
        "summary": {
          "type": "string"
        },
        "topics": {
          "type": "array"
        }
      },
      "required": [
        "title",
        "summary",
        "topics"
      ],
      "additionalProperties": false
    }
  end
end