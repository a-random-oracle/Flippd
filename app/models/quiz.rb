class Quiz
  attr_reader :name, :questions

  def initialize(quiz_json)
    @name = quiz_json['name']
    @questions = questions_from(quiz_json)
  end

  def self.load_from_config(id)
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
      qclass = class_name_from_json_type(question_json['type'])
      Questions.const_get(qclass).new(index, question_json) rescue nil
    end.compact
  end

  def class_name_from_json_type(json_type)
    json_type.gsub('-', ' ').gsub(/\w+/, &:capitalize).gsub(' ', '')
  end
end
