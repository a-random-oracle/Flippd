require_relative '../event'

module KarmaStrategies
  class CompleteQuizStrategy
    STRATEGY_FOR = :complete_quiz

    def self.award_karma(event)
      event.user.award_karma((event.details['result'].percentage * 53) / 100)
    end
  end
end