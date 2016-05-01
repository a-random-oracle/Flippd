require_relative 'json_validator'

class QuizzesValidator
  def self.validate(resource)
    JSONValidator.validate(resource, self.schema)
  end
  
  def self.schema
    {
      "$schema": "http://json-schema.org/draft-04/schema#",
      "title": "Schema for Flippd quizzes data file",
      "type": "object",
      "additionalProperties": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "questions": {
            "type": "array",
            "items": {
              "type": "object",
              "oneOf": self.assemble_question_schemas,
            }
          }
        },
        "additionalProperties": false,
        "required": [
          "name",
          "questions"
        ]
      }
    }
  end

  def self.assemble_question_schemas
    Questions.constants.collect do |qclass|
      Questions.const_get(qclass).schema
    end
  end
end