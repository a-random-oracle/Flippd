class Flippd < Sinatra::Application
  get '/quizzes/:id' do
    id = params['id']
    @quiz = Quiz.load_from_config(id)
    pass unless @quiz

    @result = @user.is_logged_in? && @user.quiz_results.first({:quiz_id => id})
    erb @result ? :quiz_results : :quiz
  end

  post '/quizzes/:id' do
    id = params['id']
    @quiz = Quiz.load_from_config(id)
    pass unless @quiz

    @result = @quiz.mark(params)

    if @user.has_permission? :take_assessment then
      @user.quiz_results << @result
      @user.award_karma((@result.percentage * 60) / 100)
      @user.save
    end

    erb :quiz_results
  end
end
