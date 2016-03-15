require_relative '../question-feedback'

module Questions
  class MultipleSelect
    def initialize(index, question_json)
      @index = index
      @text = question_json['question'] or raise "No question text provided"

      @options = question_json['options']
      raise "No options provided" unless @options && @options.length > 0

      @answer = question_json['answer']
      raise "No answers provided" unless @answer && @answer.length > 0
      raise "Invalid answer(s) provided" unless @answer.all? do |answer|
        answer.is_a?(Integer) && answer >= 0 && answer < @options.length
      end
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

    private

    def feedback_string
      answers = @answer.collect{ |a| %("#{@options[a]}") }.join(' and ')
      "The correct answers were #{answers}."
    end
  end
end
