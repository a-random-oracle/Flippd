require 'open-uri'
require 'json'
require_relative '../models/gamified_action.rb'
require_relative '../models/quiz-result.rb'

class KarmaCalculator
  def initialize
    @action_values = JSON.load(open(ENV['CONFIG_URL'] + "karma.json"))
  end

  def calculate(user_id)
    calculate_add_comment_score(user_id) + calculate_complete_quiz_score(user_id)
  end

  def calculate_add_comment_score(user_id)
    action_type = 'add-comment'
    action_value = @action_values[action_type]
    action_count = GamifiedAction.count(:action_type => action_type, :user_id => user_id)
    action_count * action_value
  end

  def calculate_complete_quiz_score(user_id)
    action_type = 'complete-quiz'
    action_value = @action_values[action_type]
    quiz_result_actions = GamifiedAction.all(:action_type => action_type, :user_id => user_id)

    # For each quiz completed by the user, find the result and award a portion of
    # the available karma according to their percentage scored
    quiz_result_actions.reduce(0) do |karma_contribution, action|
      result_id = action.details['result_id']
      percentage_correct = QuizResult.get(result_id).percentage
      karma_contribution + ((percentage_correct * action_value) / 100)
    end
  end
end