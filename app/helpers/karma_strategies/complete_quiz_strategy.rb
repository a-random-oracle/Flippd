module KarmaStrategies
  class CompleteQuizStrategy
    STRATEGY_FOR = :complete_quiz

    def self.award_karma(event)
      event.user.award_karma((event.details['result'].percentage * KarmaStrategies::get_event_value(event)) / 100)
    end
  end
end