require_relative '../question-feedback'

module Questions
  class TextBox
    def initialize(index, question_json)
      @index = index
      @text = question_json['question'] or raise "No text provided"
      @answer = question_json['answer'] or raise "No answer provided"
    end

    def name
      @text
    end

    def mark(answer)
      correct = answer && (answer.strip == @answer.strip)
      QuestionFeedback.new(correct, correct ? nil : %(The correct answer was "#{@answer}".))
    end

    def to_html
      %(<input type="text" name="q-#{@index}" />)
    end
  end
end
