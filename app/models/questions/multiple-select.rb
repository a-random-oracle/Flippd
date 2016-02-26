require_relative '../question-feedback'

module Questions
  class MultipleSelect
    def initialize(index, question_json)
      @index = index
      @text = question_json['question']
      @options = question_json['options']
      @answer = question_json['answer']
    end

    def name
      @text
    end

    def mark(answer)
      correct = answer == @answer.collect { |a| a.to_s }
      QuestionFeedback.new(correct, correct ? nil : feedback_string)
    end

    def to_html
      @options.collect.with_index do |option, index|
        id = "q-#{@index}-#{index}"
        %(<div>
            <input id="#{id}" type="checkbox" name="q-#{@index}[]" value="#{index}" />
            <label for="#{id}">#{option}</label>
          </div>)
      end.join("\n")
    end

    def self.schema
      {
        "properties": {
          "question": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "pattern": "^multiple-select$"
          },
          "options": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "answer": {
            "type": "array",
            "items": {
              "type": "integer"
            }
          }
        },
        "required": [
          "question",
          "type",
          "options",
          "answer"
        ],
        "additionalProperties": false
      }
    end

    private

    def feedback_string
      answers = @answer.collect{ |a| %("#{@options[a]}") }.join(' and ')
      "The correct answers were #{answers}."
    end
  end
end
