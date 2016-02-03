class Flippd < Sinatra::Application
  get '/quizzes/:id' do
    @quiz = Quiz.load_from_config(params['id'])
    pass unless @quiz
    erb :quiz
  end

  post '/quizzes/:id' do
    @quiz = Quiz.load_from_config(params['id'])
    pass unless @quiz

    @marks = @quiz.mark(params)
    total_marks = @marks.count { |mark| mark.correct? }

    @percentage = ((total_marks.to_f / @quiz.marks_available.to_f) * 100).round
    erb :quiz_results
  end
end
