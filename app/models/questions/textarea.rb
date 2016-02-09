module Questions
  class Textarea
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
      QuestionMark.new(correct, correct ? nil : %(The correct answer was "#{@answer}".))
    end

    def to_html
      %(<textarea name="q-#{@index}"></textarea>)
    end
  end
end
