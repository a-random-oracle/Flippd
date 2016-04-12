QuestionFeedback = Struct.new(:correct?, :feedback) do
  def to_json(*a)
    to_h.to_json(*a)
  end

  def self.from_json(json)
    self.new(json['correct?'], json['feedback'])
  end
end
