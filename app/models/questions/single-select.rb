require_relative '../question-feedback'

module Questions
  class SingleSelect
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
      correct = answer == @answer.to_s
      QuestionFeedback.new(correct, correct ? nil : %(The correct answer was "#{@options[@answer]}".))
    end

    def to_html
      options_html = @options.collect.with_index do |option, index|
        id = "q-#{@index}-#{index}"
        %(<div>
            <input id="#{id}" type="radio" name="q-#{@index}" value="#{index}" />
            <label for="#{id}">#{option}</label>
          </div>)
      end
      options_html.join("\n")
    end
  end
end
