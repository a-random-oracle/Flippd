require 'json-schema'
require_relative 'quiz-result'

class Quiz
  attr_reader :id, :name, :questions

  def initialize(id, quiz_json)
    @id = id
    @name = quiz_json['name']
    @questions = questions_from(quiz_json)
  end

  def self.load_from_config(id)
    quizzes = JSON.load(open(ENV['CONFIG_URL'] + "quizzes.json"))
    JSON::Validator.validate!(self.assemble_quiz_schema, quizzes)
    quizzes[id] ? Quiz.new(id, quizzes[id]) : nil
  end

  def mark(params)
    marks = @questions.collect.with_index do |question, index|
      question.mark(params["q-#{index}"])
    end
    QuizResult.new({:quiz_id => @id, :marks => marks})
  end

  private

  def questions_from(quiz_json)
    quiz_json['questions'].collect.with_index do |question_json, index|
      qclass = class_name_from_json_type(question_json['type'])
      Questions.const_get(qclass).new(index, question_json)
    end
  end

  def class_name_from_json_type(json_type)
    json_type.gsub('-', ' ').gsub(/\w+/, &:capitalize).gsub(' ', '')
  end

  def self.assemble_quiz_schema
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
