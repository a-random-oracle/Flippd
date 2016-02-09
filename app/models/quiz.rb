class Quiz
  attr_reader :name, :questions

  def initialize(quiz_json)
    @name = quiz_json['name']
    @questions = questions_from(quiz_json)
  end

  def self.from_json(id)
    quizzes = JSON.load(open(ENV['CONFIG_URL'] + "quizzes.json"))
    quizzes[id] ? Quiz.new(quizzes[id]) : nil
  end

  def mark(params)
    @questions.collect.with_index do |question, index|
      question.mark(params["q-#{index}"])
    end
  end

  def marks_available
    @questions.count
  end

  private

  def questions_from(quiz_json)
    quiz_json['questions'].collect.with_index do |question_json, index|
      qclass = question_json['type'].gsub('-', ' ').gsub(/\w+/, &:capitalize).gsub(' ', '')
      question = Questions.const_get(qclass).new(index, question_json)
    end
  end
end

QuestionMark = Struct.new(:correct?, :feedback)