class QuizResult
  include DataMapper::Resource

  belongs_to :user

  property :id, Serial
  property :quiz_id, String, required: true
  property :marks, Json, required: false, default: [], lazy: false

  def marks
    super.collect do |mark|
      QuestionFeedback.from_json(mark)
    end
  end

  def marks_available
    marks.count
  end

  def total_marks
    marks.count { |mark| mark.correct? }
  end

  def percentage
    @percentage || @percentage = ((total_marks.to_f / marks_available.to_f) * 100).round
  end
end
