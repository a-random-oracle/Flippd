require_relative '../question-feedback'

module Questions
  class TextArea
    def initialize(index, question_json)
      @index = index
      @text = question_json['question']
      @answer = question_json['answer']
    end

    def name
      @text
    end

    def mark(answer)
      correct = answer && (answer.strip == @answer.strip)
      QuestionFeedback.new(correct, correct ? nil : %(The correct answer was "#{@answer}".))
    end

    def to_html
      %(<textarea name="q-#{@index}"></textarea>)
    end

    def self.schema
      {
        "properties": {
          "question": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "pattern": "^text-area$"
          },
          "answer": {
            "type": "string"
          }
        },
        "required": [
          "question",
          "type",
          "answer"
        ],
        "additionalProperties": false
      }
    end
  end
end
